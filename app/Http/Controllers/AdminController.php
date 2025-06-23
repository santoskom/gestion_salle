<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveAdminRequest;
use App\Models\Departement;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\company;
use App\Notifications\SendEmailToAdminRegister;
use App\Notifications\SendEmailUpdateToAdmin;
use App\Traits\ChecksAdminRole;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;

class AdminController extends Controller
{
    use ChecksAdminRole;

    public function index()
    {
        $companys = company::all();
        $departements = Departement::pluck('nom', 'id');
        $roles = Role::pluck('nom', 'id');
        $permissions = Permission::pluck('nom', 'id');
        $users = User::paginate(10);

        return view('admins.index', compact(
            'users',
            'departements',
            'roles',
            'permissions',
            'companys',
            'companys'
        ));
    }

    public function create()
    {

        $companys = company::all();
        $departements = Departement::all();
        $roles = Role::all();
        $permissions = Permission::all();
        return view('admins.create', compact(
            'departements',
            'roles',
            'permissions',
            'companys',
            'companys'
        ));
    }

    public function edit(User $user)
    {
        $companys = company::all();
        $departements = Departement::all();
        $roles = Role::all();
        $permissions = Permission::all();
        return view('admins.edit', compact(
            'user',
            'departements',
            'roles',
            'permissions',
            'companys',
            'companys'
        ));
    }

    public function store(SaveAdminRequest $request)
    {

        try {
            $validated = $request->validated();
            $plainPassword = $validated['password'];
            // Création de l'utilisateur sans les permissions (relation many-to-many)
            $user = User::create([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'password' => bcrypt($plainPassword),
                'departement_id' => $validated['departement_id'] ?? null,
                'id_role' => $validated['id_role'],
                'company_id' => $validated['company_id'],
                'receive_notifications' => $validated['receive_notifications'] ?? true,
            ]);

            // Attacher les permissions sélectionnées
            if (isset($validated['id_permissions']) && is_array($validated['id_permissions'])) {
                $user->permissions()->attach($validated['id_permissions']);
            }

            if ($user) {
                // Envoi d'un email de confirmation de création de compte 
                try {
                    $user->notify(new SendEmailToAdminRegister($user->email));
                } catch (\Exception $e) {
                    dd("Erreur lors de l'envoi de l'email de notification : " . $e->getMessage());
                }
            }

            return redirect()
                ->route('admins.index')
                ->with('success_message', 'Administrateur ajouté avec succès.');
        } catch (\Exception $e) {
            // Log ou gérer l'erreur
            dd($e);
        }
    }

    public function update(User $user, SaveAdminRequest $request)
    {
        // dd($request);
        try {
            $validated = $request->validated();

            $userData = [
                'name' => $validated['name'],
                'email' => $validated['email'],
                'departement_id' => $validated['departement_id'] ?? null,
                'id_role' => $validated['id_role'],
                'company_id' => $validated['company_id'],
                'receive_notifications' => $validated['receive_notifications'] ?? true,
            ];

            if (!empty($validated['password'])) {
                $planPassword = $validated['password'];
                $userData['password'] = bcrypt($planPassword);
                $userData['matricule'] = $planPassword;
            }

            // Comparer les anciens et nouveaux champs
            $changes = [];
            foreach ($userData as $key => $newValue) {
                if ($key === 'password') continue;
                $oldValue = $user->{$key};
                if ($oldValue != $newValue) {
                    $changes[$key] = [
                        'old' => $oldValue ?? '—',
                        'new' => $newValue ?? '—',
                    ];
                }
            }
            if (!$request->has('company_id')) {
                unset($validated['company_id']);
            }
            // Mise à jour
            $user->update($userData);

            // Permissions
            if (isset($validated['id_permissions'])) {
                $user->permissions()->sync($validated['id_permissions']);
            } else {
                $user->permissions()->detach();
            }

            // Tenter l'envoi de la notification
            if (!empty($changes)) {
                try {
                    $user->notify(new SendEmailUpdateToAdmin($changes));
                } catch (\Exception $e) {
                    \Log::error("Erreur d'envoi de notification : " . $e->getMessage());
                    session()->flash('warning_message', "Compte modifié, mais l'e-mail de notification n'a pas pu être envoyé.");
                }
            }

            return redirect()
                ->route('admins.index')
                ->with('success_message', 'Administrateur mis à jour avec succès.');
        } catch (\Exception $e) {
            dd($e);
        }
    }

    /**
     * Supprime un utilisateur administrateur
     */
    public function delete(User $user)
    {
        try {
            // Sécurité supplémentaire : empêcher la suppression de soi-même éventuellement
            if ($user->id === auth()->id()) {
                return redirect()
                    ->route('admins.index')
                    ->withErrors(['error' => 'Vous ne pouvez pas supprimer votre propre compte administrateur.']);
            }

            $user->permissions()->detach(); // Détacher les permissions liées
            $user->delete();

            return redirect()
                ->route('admins.index')
                ->with('success_message', 'utilisatuer supprimé avec succès.');
        } catch (\Throwable $th) {
            \Log::error('Erreur lors de la suppression d\'un admin : ' . $th->getMessage());
            return redirect()
                ->route('admins.index')
                ->withErrors(['error' => 'Une erreur est survenue lors de la suppression de l\'utilisateur.']);
        }
    }
}

<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveReservationRequests;
use App\Models\Equipement;
use App\Models\Reservations;
use App\Models\Role;
use App\Models\Salle;
use App\Models\User;
use App\Notifications\BookingValidated;
use App\Notifications\NewRequestBooking;
use App\Notifications\ReservationDeclined;
use App\Traits\ChecksUserRole;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\DB;

class ReservationsController extends Controller
{
    use ChecksUserRole;

    /**
     * Affiche la liste des réservations de l'utilisateur
     */
    public function index()
    {
        $userCompanyId = auth()->user()->company_id;

        if ($this->userHasRole('Assistant de directions')) {


            $reservations = Reservations::with(['salle', 'demandeur'])
                ->whereHas('salle', function ($query) use ($userCompanyId) {
                    $query->where('company_id', $userCompanyId);
                })
                ->orderBy('created_at', 'desc')
                ->paginate(7);
        } else {


            $reservations = Reservations::with(['salle'])
                ->where('id_demandeur', auth()->id())
                ->whereHas('salle', function ($query) use ($userCompanyId) {
                    $query->where('company_id', $userCompanyId);
                })
                ->orderBy('created_at', 'desc')
                ->paginate(7);
        }

        return view('reservations.index', compact('reservations'));
    }



    /**
     * Recherche dans les réservations
     */
    public function search(Request $request)
    {
        $searchTerm = $request->input('searchorders');
        $userCompanyId = auth()->user()->company_id;

        if (empty($searchTerm)) {


            return redirect()->route('reservations.index');
        }

        if ($this->userHasRole('Assistant de directions')) {


            $reservations = Reservations::with(['salle', 'demandeur'])
                ->whereHas('salle', function ($query) use ($userCompanyId) {
                    $query->where('company_id', $userCompanyId);
                })
                ->where(function ($query) use ($searchTerm) {
                    $query->where('objet_reunion', 'LIKE', "%{$searchTerm}%")
                        ->orWhereHas('salle', function ($q) use ($searchTerm) {
                            $q->where('nom', 'LIKE', "%{$searchTerm}%");
                        })
                        ->orWhereHas('demandeur', function ($q) use ($searchTerm) {
                            $q->where('name', 'LIKE', "%{$searchTerm}%")
                                ->orWhere('email', 'LIKE', "%{$searchTerm}%");
                        });
                })
                ->orderBy('created_at', 'desc')
                ->paginate(7);
        } else {


            $reservations = Reservations::with(['salle'])
                ->where('id_demandeur', auth()->id())
                ->whereHas('salle', function ($query) use ($userCompanyId) {
                    $query->where('company_id', $userCompanyId);
                })
                ->where(function ($query) use ($searchTerm) {
                    $query->where('objet_reunion', 'LIKE', "%{$searchTerm}%")
                        ->orWhereHas('salle', function ($q) use ($searchTerm) {
                            $q->where('nom', 'LIKE', "%{$searchTerm}%");
                        });
                })
                ->orderBy('created_at', 'desc')
                ->paginate(7);
        }



        $reservations->appends(['searchorders' => $searchTerm]);

        return view('reservations.index', compact('reservations', 'searchTerm'));
    }

    /**
     * Affiche le formulaire de création
     */
    public function create()
    {

        $userCompanyId = auth()->user()->company_id;

        $salles = Salle::where('company_id', $userCompanyId)->get();
        $equipements = Equipement::all();

        return view('reservations.create', compact('salles', 'equipements'));
    }




    /**
     * Récupérer les réservations d'une salle pour une période donnée
     */


    public function store(SaveReservationRequests $request)
    {
        DB::beginTransaction();

        try {
            $validated = $request->validated();
            $user = auth()->user();
            $userCompanyId = $user->company_id;

            $salle = Salle::findOrFail($validated['salle_id']);

            if ($salle->company_id !== $userCompanyId) {
                throw new \Exception("Vous n'avez pas accès à cette salle.");
            }

            if ($validated['nombreParticipants'] > $salle->capacite) {
                throw new \Exception("La capacité de la salle est dépassée. Vous avez demandé {$validated['nombreParticipants']} participants pour une salle de {$salle->capacite} places.");
            }

            $reservation = new Reservations();
            $reservation->fill($validated);
            $reservation->id_demandeur = $user->id;
            $reservation->statut = 'en_attente';

            // Validation avec l'algorithme amélioré
            if ($reservation->durationExceeded($user)) {
                $errors = $reservation->getValidationErrors();
                throw new \Exception(implode(' | ', $errors));
            }

          
            if ($reservation->hasConflict()) {
                throw new \Exception("Ce créneau est déjà réservé. Veuillez choisir un autre horaire.");
            }

            $reservation->save();

            if (!empty($validated['equipements'])) {
                $reservation->equipements()->attach($validated['equipements']);
            }

            $this->notifyAssistantsDirection($reservation, $userCompanyId);

            DB::commit();

            return redirect()->route('reservations.index')
                ->with('succes_message', 'Demande de réservation enregistrée avec succès et en attente de validation.');
        } catch (\Illuminate\Validation\ValidationException $e) {
            dd($e);
            DB::rollBack();
            Log::error('Erreur de validation dans ReservationsController@store', [
                'errors' => $e->errors(),
                'user_id' => auth()->id()
            ]);

            return back()->withInput()->withErrors($e->errors());
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            //   dd($e);
            DB::rollBack();
            Log::error('Salle non trouvée dans ReservationsController@store', [
                'salle_id' => $validated['salle_id'] ?? 'N/A',
                'user_id' => auth()->id()
            ]);

            return back()->withInput()->withErrors([
                'salle_id' => 'La salle sélectionnée n\'existe pas.'
            ]);
        } catch (\Exception $e) {
            // dd($e);
            DB::rollBack();
            Log::error('Erreur dans ReservationsController@store', [
                'message' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'user_id' => auth()->id(),
                'validated_data' => $validated ?? []
            ]);

            $errorMessage = $e->getMessage();

            if (str_contains($errorMessage, 'heures d\'ouverture')) {
                $errorMessage = 'La réservation ne respecte pas les heures d\'ouverture (8h-20h)';
            }

            return back()->withInput()->withErrors([
                'general' => $errorMessage
            ]);
        } catch (\Throwable $th) {
            // dd($th);
            DB::rollBack();
            Log::error('Erreur critique dans ReservationsController@store', [
                'message' => $th->getMessage(),
                'file' => $th->getFile(),
                'line' => $th->getLine(),
                'trace' => $th->getTraceAsString(),
                'user_id' => auth()->id()
            ]);

            return back()->withInput()->withErrors([
                'general' => 'Une erreur technique inattendue s\'est produite. Veuillez réessayer ou contacter l\'administrateur.'
            ]);
        }
    }



    /**
     * Affiche les détails d'une réservation
     */
    public function show(Reservations $reservation)
    {

        if (!$this->canSee($reservation)) {
            abort(403, 'Accès non autorisé.');
        }

        $userCompanyId = auth()->user()->company_id;
        if ($reservation->salle->company_id !== $userCompanyId) {
            abort(403, "Vous n'avez pas accès à cette réservation.");
        }

        $reservation->load(['salle', 'demandeur', 'createur', 'equipements']);

        return view('reservations.show', compact('reservation'));
    }

    /**
     * Affiche le formulaire de modification
     */
    public function edit(Reservations $reservation)
    {


        if (!$this->mayEdit($reservation)) {
            abort(403, 'Accès non autorisé.');
        }



        $userCompanyId = auth()->user()->company_id;
        if ($reservation->salle->company_id !== $userCompanyId) {
            abort(403, "Vous n'avez pas accès à cette réservation.");
        }

        $users = User::where('company_id', $userCompanyId)->get();
        $roles = Role::all();
        $equipements = Equipement::all();
        $salles = Salle::where('company_id', $userCompanyId)->get();


        $reservation->load('equipements');


        $user = $reservation->demandeur;
        $user->load('permissions');
        $permissions = $user->permissions;

        $equipementsSelectionnes = $reservation->equipements->pluck('id')->toArray();

        return view('reservations.edit', compact(
            'reservation',
            'salles',
            'equipements',
            'equipementsSelectionnes',
            'users',
            'permissions'
        ));
    }

    /**
     * Met à jour une réservation existante
     */


    public function update(SaveReservationRequests $request, Reservations $reservation)
    {
        DB::beginTransaction();

        try {
            // Vérification des droits
            if (!$this->mayEdit($reservation)) {
                throw new \Exception("Vous n'avez pas les droits nécessaires.");
            }

            $user = auth()->user();
            $userCompanyId = $user->company_id;
            $validated = $request->validated();

            // Vérification de la salle
            $salle = Salle::findOrFail($validated['salle_id']);

            if ($salle->company_id !== $userCompanyId) {
                throw new \Exception("Accès refusé à cette salle.");
            }

            if ($validated['nombreParticipants'] > $salle->capacite) {
                throw new \Exception("Capacité dépassée : {$validated['nombreParticipants']}/{$salle->capacite}");
            }

            // Mise à jour des données
            $reservation->fill($validated);

            // Gestion revalidation : si déjà validée et modifiée par un autre rôle
            $needsRevalidation = $reservation->isValidated() && !$this->userHasRole('Assistants de directions');
            if ($needsRevalidation) {
                $reservation->statut = 'en_attente';
            }

            // Validation de la durée
            if ($reservation->durationExceeded($user)) {
                throw new \Exception(implode(' | ', $reservation->getValidationErrors()));
            }

            // Vérification de conflit
            if ($reservation->hasConflict()) {
                $conflictResult = $reservation->aConflit();
                if ($conflictResult['conflicting_with']) {
                    throw new \Exception("Conflit détecté avec une réservation existante.");
                }
                throw new \Exception("Ce créneau est déjà réservé.");
            }

            // Sauvegarde
            $reservation->save();

            // Synchronisation des équipements
            $reservation->equipements()->sync($validated['equipements'] ?? []);

            // Notification si revalidation requise
            if ($needsRevalidation) {
                $this->notifyAssistantsDirection($reservation, $userCompanyId);
            }

            DB::commit();

            return redirect()->route('reservations.index')
                ->with('succes_message', 'Réservation mise à jour avec succès' . ($needsRevalidation ? ' - En attente de revalidation' : ''));
        } catch (\Throwable $th) {
            DB::rollBack();
            Log::critical('Erreur critique mise à jour réservation: ' . $th->getMessage());

            return back()->withInput()->withErrors([
                'general' => 'Une erreur technique est survenue. Veuillez réessayer ou contacter l\'administrateur.'
            ]);
        }
    }

    /**
     * Supprime une réservation
     */
    public function destroy(Reservations $reservation)
    {
        try {

            if (!$this->mayRemove($reservation)) {
                abort(403, 'Accès non autorisé.');
            }


            $userCompanyId = auth()->user()->company_id;
            if ($reservation->salle->company_id !== $userCompanyId) {
                abort(403, "Vous n'avez pas accès à cette réservation.");
            }


            DB::transaction(function () use ($reservation) {
                $reservation->equipements()->detach();
                $reservation->delete();
            });

            return redirect()->route('reservations.index')
                ->with('succes_message', 'Réservation supprimée avec succès.');
        } catch (\Throwable $th) {
            Log::error('Erreur lors de la suppression de réservation: ' . $th->getMessage());

            return redirect()->route('reservations.index')
                ->with('error', 'Une erreur est survenue lors de la suppression. Veuillez réessayer plus tard.');
        }
    }



    /**
     * Affiche les réservations en attente (pour les assistants)
     */
    public function Pending()
    {
        if (!$this->userHasRole('Assistant de directions')) {
            return redirect()->route('dashbord')
                ->with('error', "⛔ Vous n'avez pas l'autorisation d'accéder aux réservations en attente.");
        }

        $userCompanyId = auth()->user()->company_id;

        $reservations = Reservations::with(['salle', 'demandeur'])
            ->where('statut', 'en_attente')
            ->whereHas('salle', function ($query) use ($userCompanyId) {
                $query->where('company_id', $userCompanyId);
            })
            ->orderBy('created_at', 'asc')
            ->paginate(10);

        return view('reservations.en-attente', compact('reservations'));
    }

    
    public function validate(Reservations $reservation)
    {
        DB::beginTransaction();

        try {
            // Vérification des permissions
            if (!$this->userHasRole('Assistant de directions')) {
                throw new \Exception("Accès refusé : Seuls les assistants de direction peuvent valider les réservations.");
            }

            // Vérification de l'entreprise
            $userCompanyId = auth()->user()->company_id;
            if ($reservation->salle->company_id !== $userCompanyId) {
                throw new \Exception("Accès refusé : Cette réservation ne concerne pas votre entreprise.");
            }

            // Vérification du statut
            if (method_exists($reservation, 'isPending') && !$reservation->isPending()) {
                throw new \Exception("Statut invalide : Cette réservation a déjà été traitée.");
            }

            // Vérification si la réservation est passée
            if ($reservation->isPast()) {
                $status = $reservation->getTimeStatus();

                $errorMessage = match ($status['status']) {
                    'completed' => 'Date dépassée : Impossible de valider une réservation déjà terminée',
                    'in_progress', 'started' => 'Réunion en cours : Impossible de valider une réunion déjà commencée',
                    default => 'Date invalide : Cette réservation ne peut plus être validée'
                };

                throw new \Exception($errorMessage);
            }

            // Vérification des conflits
            $conflictResult = $reservation->aConflit();
            if ($conflictResult['has_conflict']) {
                $conflictingReservation = $conflictResult['conflicting_with'];
                $message = $conflictingReservation
                    ? "Conflit de réservation : Créneau déjà réservé pour \"{$conflictingReservation->objet_reunion}\" (" .
                    $conflictingReservation->date_debut->format('d/m/Y H:i') . " - " .
                    $conflictingReservation->date_fin->format('H:i') . ")"
                    : "Conflit de réservation : Ce créneau est déjà réservé";

                throw new \Exception($message);
            }

            // Validation et notification
            $reservation->statut = 'valide';
            $reservation->id_createur = auth()->id();
            $reservation->save();

            if ($reservation->demandeur) {
                try {
                    $reservation->demandeur->notify(new BookingValidated($reservation));
                    Log::info('Notification envoyée à ' . $reservation->demandeur->email);
                } catch (\Throwable $e) {
                    Log::error('Erreur d\'envoi de notification: ' . $e->getMessage());
                }
            }

            DB::commit();

            return redirect()
                ->route('reservations.en-attente')
                ->with('success', 'La réservation a été approuvée avec succès.');
        } catch (\Throwable $th) {
            DB::rollBack();
            Log::error('Erreur de validation: ' . $th->getMessage());

            return back()
                ->withInput()
                ->withErrors([
                    'general' => $th->getMessage() // Le message sera formaté par votre vue
                ]);
        }
    }

    /**
     * Refuse une réservation (pour les assistants)
     */
    public function refuse(Reservations $reservation)
    {
        DB::beginTransaction();

        try {

            if (!$this->userHasRole('Assistant de directions')) {
                return redirect()->route('dashbord')
                    ->with('error', "⛔ Vous n'avez pas l'autorisation pour effectuer des validations.");
            }


            $userCompanyId = auth()->user()->company_id;
            if ($reservation->salle->company_id !== $userCompanyId) {
                return redirect()->route('dashbord')
                    ->with('error', "⛔ Vous n'avez pas accès à cette réservation.");
            }


            if (method_exists($reservation, 'isPending') && !$reservation->isPending()) {
                return back()->withErrors([
                    'statut' => 'Cette réservation ne peut plus être refusée.'
                ]);
            }


            $reservation->statut = 'annulee';
            $reservation->id_createur = auth()->id();
            $reservation->save();


            if ($reservation->demandeur) {
                try {
                    $reservation->demandeur->notify(new ReservationDeclined($reservation));
                    Log::info('Notification de refus envoyée à ' . $reservation->demandeur->email);
                } catch (\Throwable $e) {
                    Log::error('Erreur lors de l\'envoi de notification de refus: ' . $e->getMessage());
                }
            }

            DB::commit();

            return redirect()->route('reservations.en-attente')
                ->with('error', "⛔ Réservation refusée.");
        } catch (\Throwable $th) {
            DB::rollBack();
            Log::error('Erreur lors du refus de réservation: ' . $th->getMessage());

            return redirect()->route('reservations.en-attente')
                ->with('error', 'Une erreur est survenue lors du traitement. Veuillez réessayer plus tard.');
        }
    }

    /**
     * Notifie les assistants de direction de la même compagnie d'une nouvelle demande
     */
    private function notifyAssistantsDirection(Reservations $reservation, $companyId)
    {
        try {
            $roleAssistant = Role::where('nom', 'Assistant de directions')->first();

            if (!$roleAssistant) {
                Log::warning('Rôle "Assistant de directions" non trouvé lors de l\'envoi des notifications');
                return;
            }


            $assistants = User::where('id_role', $roleAssistant->id)
                ->where('company_id', $companyId)
                ->get();

            if ($assistants->isEmpty()) {
                Log::info('Aucun assistant de direction trouvé pour la compagnie ' . $companyId);
                return;
            }


            $reservationInfo = "ID: {$reservation->id}, Salle: {$reservation->salle->nom}, Date: {$reservation->date_debut}";

            foreach ($assistants as $assistant) {
                try {

                    if (empty($assistant->email)) {
                        Log::warning("Assistant ID {$assistant->id} n'a pas d'email, notification ignorée");
                        continue;
                    }

                    $assistant->notify(new NewRequestBooking($reservation));
                    Log::info("Notification de nouvelle réservation ({$reservationInfo}) envoyée à {$assistant->email}");
                } catch (\Throwable $e) {
                    Log::error("Erreur lors de l'envoi de notification à {$assistant->email}: " . $e->getMessage());
                }
            }
        } catch (\Throwable $e) {
            Log::error('Erreur globale dans notifyAssistantsDirection: ' . $e->getMessage());
            throw $e;
        }
    }

    /**
     * Exporte l'historique des réservations (pour les assistants)
     */
    public function export(Request $request)
    {

        if (!$this->userHasRole('Assistant de directions')) {
            abort(403, 'Accès non autorisé.');
        }

        $userCompanyId = auth()->user()->company_id;


        $dateDebut = $request->input('date_debut');
        $dateFin = $request->input('date_fin');
        $statut = $request->input('statut');


        $query = Reservations::with(['salle', 'demandeur', 'createur'])
            ->whereHas('salle', function ($query) use ($userCompanyId) {
                $query->where('company_id', $userCompanyId);
            });


        if ($dateDebut) {
            $query->where('date_debut', '>=', $dateDebut);
        }

        if ($dateFin) {
            $query->where('date_fin', '<=', $dateFin);
        }

        if ($statut && $statut != 'tous') {
            $query->where('statut', $statut);
        }


        $reservations = $query->orderBy('date_debut', 'desc')->get();


        $filename = 'export_reservations_' . date('Y-m-d_His') . '.csv';
        $headers = [
            'Content-type' => 'text/csv',
            'Content-Disposition' => 'attachment; filename=' . $filename,
            'Pragma' => 'no-cache',
            'Cache-Control' => 'must-revalidate, post-check=0, pre-check=0',
            'Expires' => '0'
        ];

        $handle = fopen('php://output', 'w');


        fputcsv($handle, [
            'ID',
            'Salle',
            'Objet',
            'Description',
            'Date début',
            'Date fin',
            'Heure début',
            'Heure fin',
            'Participants',
            'Statut',
            'Rappel',
            'Demandeur',
            'Traité par',
            'Date création',
            'Date modification'
        ]);


        foreach ($reservations as $reservation) {
            fputcsv($handle, [
                $reservation->id,
                $reservation->salle->nom ?? '—',
                $reservation->objet_reunion,
                $reservation->description,
                $reservation->date_debut,
                $reservation->date_fin,
                $reservation->heure_debut,
                $reservation->heure_fin,
                $reservation->nombreParticipants,
                $this->translateStatus($reservation->statut),
                $reservation->rappel_active ? 'Oui' : 'Non',
                $reservation->demandeur->name ?? '—',
                $reservation->createur->name ?? '—',
                $reservation->created_at,
                $reservation->updated_at
            ]);
        }

        fclose($handle);

        return response()->stream(function () use ($handle) {}, 200, $headers);
    }

    /**
     * Traduit le statut en format lisible
     */
    private function translateStatus($statut)
    {
        switch ($statut) {
            case 'en_attente':
                return 'En attente';
            case 'valide':
                return 'Validée';
            case 'annulee':
                return 'Annulée/Refusée';
            default:
                return $statut;
        }
    }

    /**
     * Vérifie si l'utilisateur peut supprimer une réservation
     */
    protected function mayRemove(Reservations $reservation)
    {

        if ($reservation->id_demandeur === auth()->id()) {
            return true;
        }


        if ($this->isAdmin() || $this->isAssistantDirecteur()) {

            $userCompanyId = auth()->user()->company_id;
            return $reservation->salle->company_id === $userCompanyId;
        }

        return false;
    }

    /**
     * Vérifie si l'utilisateur peut modifier une réservation
     */
    public function mayEdit($reservation): bool
    {

        $user = auth()->user();


        if (!$user) {
            return false;
        }


        if (is_numeric($reservation)) {
            $reservation = Reservations::find($reservation);

            if (!$reservation) {
                return false;
            }
        }


        if ($reservation->salle->company_id !== $user->company_id) {
            return false;
        }


        if ($this->isAdmin()) {
            return true;
        }


        if ($this->isAssistantDirecteur()) {
            return true;
        }


        if ($reservation->id_demandeur === $user->id) {

            $estValidee = property_exists($reservation, 'est_validee') ? $reservation->est_validee : ($reservation->statut === 'valide');
            $estRejetee = property_exists($reservation, 'est_rejetee') ? $reservation->est_rejetee : ($reservation->statut === 'annulee');

            $dateDebut = $reservation->date_debut;
            if (!($dateDebut instanceof \Carbon\Carbon)) {
                $dateDebut = \Carbon\Carbon::parse($dateDebut);
            }

            return !$estValidee && !$estRejetee && $dateDebut > now();
        }


        return false;
    }

    /**
     * Vérifie si l'utilisateur peut voir une réservation
     */
    protected function canSee(Reservations $reservation): bool
    {
        $user = auth()->user();


        if (!$user) {
            return false;
        }


        if ($reservation->salle->company_id !== $user->company_id) {
            return false;
        }


        if ($this->isAdmin() || $this->isAssistantDirecteur()) {
            return true;
        }


        return $reservation->id_demandeur === $user->id;
    }

    /**
     * Vérifie si l'utilisateur est administrateur
     */
    protected function isAdmin(): bool
    {
        return $this->userHasRole('Administrateur');
    }

    /**
     * Vérifie si l'utilisateur est assistant de direction
     */
    protected function isAssistantDirecteur(): bool
    {
        return $this->userHasRole('Assistant de directions');
    }
}

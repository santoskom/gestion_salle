<?php

namespace App\Http\Controllers;

use \Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class PasswordResetController extends Controller
{
    public function showForm()
    {
        return view('auth.forgot-password');
    }

 public function handle(Request $request)
{
    $request->validate([
        'email' => 'required|email|exists:users,email',
    ]);

    try {
        $user = User::where('email', $request->email)->firstOrFail();

        

        $newPassword = Str::password(8);

        

        $user->matricule = $newPassword; 

        $user->password = Hash::make($newPassword); 

        $user->save();

        

        Mail::send('emails.password-reset', [
            'password' => $newPassword,
            'user' => $user
        ], function ($message) use ($user) {
            $message->to($user->email)
                   ->subject("Réinitialisation de votre mot de passe");
        });

        if (count(Mail::failures())) {
            throw new \Exception("Échec d'envoi du email");
        }

        

        return redirect()->route('login')->with([
            'alert_type' => 'success',
            'alert_icon' => 'fa-check-circle',
            'alert_title' => 'Succès',
            'alert_message' => 'Un nouveau mot de passe a été envoyé à votre adresse email.'
        ]);

    } catch (ModelNotFoundException $e) {
        return redirect()->route('login')->with([
            'alert_type' => 'danger',
            'alert_icon' => 'fa-exclamation-triangle',
            'alert_title' => 'Utilisateur introuvable',
            'alert_message' => 'Aucun compte ne correspond à cette adresse email.'
        ]);

    } catch (\Exception $e) {
        Log::error('Erreur réinitialisation mot de passe: ' . $e->getMessage());
        
        return redirect()->route('login')->with([
            'alert_type' => 'danger',
            'alert_icon' => 'fa-exclamation-circle',
            'alert_title' => 'Erreur technique',
            'alert_message' => 'Une erreur est survenue. Veuillez réessayer plus tard.'
        ]);
    }
}
}
 


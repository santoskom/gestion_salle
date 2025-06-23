<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SendEmailToAdminRegister extends Notification
{
    use Queueable;

public $email;
    /**
     * Create a new notification instance.
     */
    public function __construct($email)
    {
        $this->email=$email;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail','database'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('Création de votre compte administrateur')
            ->greeting('Bonjour ' . $notifiable->name)
            ->line('Votre compte a été créé avec succès sur la plateforme de gestion des salles.')
            ->line('Vous pouvez maintenant vous connecter à l’aide de votre adresse email et le matricule fourni.')
            ->line('Merci d’avoir rejoint notre plateforme !');
    }

    /**
     * Get the array representation of the notification.
     */
    public function toArray(object $notifiable): array
    {
        return [
            'email' => $this->email,
        ];
    }
    public function toDatabase(object $notifiable): array
{
    return [
        'message' => 'Le compte a été créé pour ' . $this->email,
        'email' => $this->email,
        'type' => 'Création de compte',
    ];
}
}
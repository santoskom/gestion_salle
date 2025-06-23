<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SendEmailUpdateToAdmin extends Notification
{
    use Queueable;
    public array $changes;
    /**
     * Create a new notification instance.
     */
    public function __construct(array $changes)
    {
       $this->changes=$changes;
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
        $mail = (new MailMessage)
        ->subject('Mise à jour de votre compte')
        ->greeting('Bonjour ' . $notifiable->name)
        ->line('Votre compte a été mis à jour.');

    foreach ($this->changes as $field => $values) {
        $mail->line(ucfirst($field) . ': "' . $values['old'] . '" → "' . $values['new'] . '"');
    }

    return $mail->action('Se connecter', url('/login'))
                ->salutation('Merci.');
}

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
    public function toDatabase($notifiable)
    {
        return [
            'title' => 'Compte mis à jour',
            'message' => 'Votre compte a été modifié.',
            'changes' => $this->changes,
        ];
    }
}

<?php

namespace App\Notifications;

use App\Models\Reservations;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class RappelReunion extends Notification
{
    use Queueable;

    protected $reservation;

    /**
     * Create a new notification instance.
     */
    public function __construct(Reservations $reservation)
    {
        $this->reservation = $reservation;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<string>
     */
    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        $url = url('/reservations/' . $this->reservation->id);
        
        return (new MailMessage)
            ->subject('Rappel : réunion imminente')
            ->greeting('Bonjour ' . $notifiable->name)
            ->line('Vous avez une réunion prévue bientôt.')
            ->line('Objet : ' . $this->reservation->objet_reunion)
            ->line('Salle : ' . optional($this->reservation->salle)->nom)
            ->line('Date : ' . \Carbon\Carbon::parse($this->reservation->date_debut)->format('d/m/Y'))
            ->line('Heure : ' . \Carbon\Carbon::parse($this->reservation->heure_debut)->format('H:i'))
            ->action('Voir le planning', url('/planning'))
            ->line('Merci.');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'reservation_id' => $this->reservation->id,
            'titre' => 'Rappel de réunion',
            'message' => "Rappel: Réunion '{$this->reservation->objet_reunion}' dans 30 minutes en salle {$this->reservation->salle->nom}",
            'url' => '/reservations/' . $this->reservation->id,
        ];
    }
}
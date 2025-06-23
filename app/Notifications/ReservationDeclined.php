<?php

namespace App\Notifications;

use App\Models\Reservations;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ReservationDeclined extends Notification
{
    use Queueable;

    protected $reservation;
    protected $motif;

    /**
     * Create a new notification instance.
     */
    public function __construct(Reservations $reservation, $motif = null)
    {
        $this->reservation = $reservation;
        $this->motif = $motif;
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
        $mailMessage = (new MailMessage)
            ->subject('Votre demande de réservation a été refusée')
            ->greeting('Bonjour ' . $notifiable->name)
            ->line('Votre demande de réservation a été refusée.')
            ->line('Salle: ' . $this->reservation->salle->nom)
            ->line('Date: ' . $this->reservation->date_debut->format('d/m/Y'))
            ->line('Horaires: ' . substr($this->reservation->heure_debut, 0, 5) . ' - ' . 
                 substr($this->reservation->heure_fin, 0, 5))
            ->line('Objet: ' . $this->reservation->objet_reunion);
        
       
        if ($this->motif) {
            $mailMessage->line('Motif du refus: ' . $this->motif);
        }
        
        $mailMessage->action('Faire une nouvelle demande', url('/reservations/create'))
            ->line('Merci d\'utiliser notre application !');
            
        return $mailMessage;
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        $message = "Votre réservation de la salle '{$this->reservation->salle->nom}' a été refusée";
        
        if ($this->motif) {
            $message .= ". Motif: {$this->motif}";
        }
        
        return [
            'reservation_id' => $this->reservation->id,
            'titre' => 'Réservation refusée',
            'message' => $message,
            'url' => '/reservations/create',
        ];
    }
}
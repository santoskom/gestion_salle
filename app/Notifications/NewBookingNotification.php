<?php

namespace App\Notifications;

use App\Models\Reservations;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class NewBookingNotification extends Notification
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
        $demandeur = $this->reservation->demandeur ? $this->reservation->demandeur->name : 'Utilisateur externe';
        
        return (new MailMessage)
            ->subject('Nouvelle demande de réservation de salle')
            ->greeting('Bonjour ' . $notifiable->name)
            ->line('Une nouvelle demande de réservation a été soumise.')
            ->line('Demandeur: ' . $demandeur)
            ->line('Salle: ' . $this->reservation->salle->nom)
            ->line('Date: ' . $this->reservation->date_debut->format('d/m/Y'))
            ->line('Horaires: ' . substr($this->reservation->heure_debut, 0, 5) . ' - ' . substr($this->reservation->heure_fin, 0, 5))
            ->line('Objet: ' . $this->reservation->objet_reunion)
            ->action('Voir la demande', $url)
            ->line('Merci d\'utiliser notre application !');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        $demandeur = $this->reservation->demandeur ? $this->reservation->demandeur->nom : 'Utilisateur externe';
        
        return [
            'reservation_id' => $this->reservation->id,
            'titre' => 'Nouvelle demande de réservation',
            'message' => "Demande de {$demandeur} pour la salle '{$this->reservation->salle->nom}' le {$this->reservation->date_debut->format('d/m/Y')}",
            'url' => '/reservations/' . $this->reservation->id,
        ];
    }
}
<?php

namespace App\Notifications;

use App\Models\Reservations;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class NewRequestBooking extends Notification  implements ShouldQueue
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
        return ['mail', 'database', 'broadcast'];
    }

    /**
     * Get the mail representation of the notification.
     */
   public function toMail(object $notifiable): MailMessage
{
    \Log::info('toMail triggered for user: ' . ($notifiable->email ?? 'unknown'));
    $url = url('/reservations/' . $this->reservation->id);
 
    $demandeur = 'Utilisateur externe';
    if ($this->reservation->demandeur) {
        $demandeur = $this->reservation->demandeur->name ?? $this->reservation->demandeur->nom ?? 'Sans nom';
    }
    
    $dateDebut = $this->reservation->date_debut;
    if (!($dateDebut instanceof \Carbon\Carbon)) {
        $dateDebut = \Carbon\Carbon::parse($dateDebut);
    }
    
    return (new MailMessage)
        ->subject('Nouvelle demande de réservation de salle')
        ->greeting('Bonjour ' . ($notifiable->name ?? $notifiable->name ?? 'Utilisateur'))
        ->line('Une nouvelle demande de réservation a été soumise.')
        ->line('Demandeur: ' . $demandeur)
        ->line('Salle: ' . ($this->reservation->salle->name ?? 'Non spécifiée'))
        ->line('Date: ' . $dateDebut->format('d/m/Y'))
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
    
    /**
     * Get the broadcastable representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return BroadcastMessage
     */
    public function toBroadcast($notifiable)
    {
        $demandeur = $this->reservation->demandeur ? $this->reservation->demandeur->nom : 'Utilisateur externe';
        
        return new BroadcastMessage([
            'reservation_id' => $this->reservation->id,
            'titre' => 'Nouvelle demande de réservation',
            'message' => "Demande de {$demandeur} pour la salle '{$this->reservation->salle->nom}' le {$this->reservation->date_debut->format('d/m/Y')}",
            'url' => '/reservations/' . $this->reservation->id,
            'salle' => $this->reservation->salle->nom,
            'demandeur' => $demandeur,
            'date' => $this->reservation->date_debut->format('d/m/Y'),
            'heure_debut' => substr($this->reservation->heure_debut, 0, 5),
            'heure_fin' => substr($this->reservation->heure_fin, 0, 5),
            'objet' => $this->reservation->objet_reunion
        ]);
    }
    
    /**
     * Get the type of the notification being broadcast.
     *
     * @return string
     */
    public function broadcastType()
    {
        return 'nouvelle.reservation';
    }
}
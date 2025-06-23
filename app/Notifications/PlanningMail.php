<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class PlanningMail extends Mailable
{
    use Queueable, SerializesModels;

    public $emailData;
    public $pdfContent;

    /**
     * Create a new message instance.
     *
     * @param array $emailData
     * @param string $pdfContent
     */
    public function __construct($emailData, $pdfContent)
    {
        $this->emailData = $emailData;
        $this->pdfContent = $pdfContent;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $message = (new \Illuminate\Mail\MailMessage)
            ->subject('Planning des réservations de salle')
            ->greeting('Bonjour,')
            ->line('Voici le planning des réservations pour la période du ' . $this->emailData['date_debut'] . ' au ' . $this->emailData['date_fin'])
            ->line('Vous trouverez le détail complet dans le PDF ci-joint.');

       
        foreach ($this->emailData['planningData'] as $date => $day) {
            if (count($day['reservations']) > 0) {
                $message->line('')
                    ->line('**' . $day['jour'] . ' ' . $day['date'] . '**');
                
                foreach ($day['reservations'] as $reservation) {
                    $message->line('- ' . $reservation->salle->nom . ' : ' . 
                        $reservation->date_debut->format('H:i') . ' - ' . 
                        $reservation->date_fin->format('H:i') . ' | ' . 
                        $reservation->objet_reunion . ' (' . 
                        ($reservation->demandeur ? $reservation->demandeur->name : 'Utilisateur externe') . ')');
                }
            }
        }

        $message->line('')
            ->action('Accéder à l\'application', url('/'))
            ->line('Merci d\'utiliser notre application !');

       
        $this->html($message->render())
            ->attachData($this->pdfContent, 'planning-reservations-' . now()->format('Y-m-d') . '.pdf', [
                'mime' => 'application/pdf',
            ]);

        return $this;
    }
}
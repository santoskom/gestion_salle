<?php

namespace App\Models;

use App\Models\Salle;
use App\Traits\ChecksUserRole;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

class Reservations extends Model
{
    public const STATUT_EN_ATTENTE = 'en_attente';
    public const STATUT_VALIDEE = 'validee';
    public const STATUT_REFUSEE = 'refusee';
    public const STATUT_ANNULEE = 'annulee';
    use HasFactory;

    protected $fillable = [
        'salle_id',
        'id_demandeur',
        'id_createur',
        'objet_reunion',
        'description',
        'date_debut',
        'date_fin',
        'statut',
        'nombreParticipants',
        'rappel_active',
    ];

    protected $casts = [
        'date_debut' => 'datetime',
        'date_fin' => 'datetime',
        'rappel_active' => 'boolean',
    ];
 protected $appends = ['statut_badge', 'duree'];
    /**
     * Relation avec la salle
     */
    public function salle()
    {
        return $this->belongsTo(Salle::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Relation avec l'utilisateur demandeur
     */
    public function demandeur()
    {
        return $this->belongsTo(User::class, 'id_demandeur');
    }

    /**
     * Relation avec l'utilisateur qui valide (Assistant de direction)
     */
    public function createur()
    {
        return $this->belongsTo(User::class, 'id_createur');
    }

    /**
     * Relation avec les équipements
     */
    public function equipements()
    {
        return $this->belongsToMany(Equipement::class, 'equipement_reservation', 'reservation_id', 'equipement_id');
    }

    /**
     * Vérifie si la réservation est en attente
     */
    public function isPending()
    {
        return $this->statut === 'en_attente';
    }

    /**
     * Vérifie si la réservation est validée
     */
    public function isValidated()
    {
        return $this->statut === self::STATUT_VALIDEE;
        
        
        if (!$this->estSalleDisponible($reservation)) {
            return redirect()->back()
                ->with('error', 'La salle n\'est plus disponible pour cette période.');
        }
        
        $reservation->update([
            'statut' => 'validé',
            'validated_by' => Auth::id(),
            'validated_at' => Carbon::now()
        ]);
    }

    /**
     * The "booted" method of the model.
     *
     * @return void
     */
    protected static function booted()
    {
        static::creating(function ($reservation) {
         
            if (!$reservation->estValideOuverture()) {
                throw new \Exception('La réservation ne respecte pas les heures d\'ouverture (8h-20h)');
            }

            if ($reservation->estJourExclu()) {
                throw new \Exception('Les réservations ne sont pas autorisées les dimanches et jours fériés');
            }
        });

        static::updating(function ($reservation) {
            if (!$reservation->estValideOuverture()) {
                throw new \Exception('La réservation ne respecte pas les heures d\'ouverture (8h-20h)');
            }

            if ($reservation->estJourExclu()) {
                throw new \Exception('Les réservations ne sont pas autorisées les dimanches et jours fériés');
            }
        });
    }


     /**
     * Vérifie si les heures de réservation respectent les horaires d'ouverture (8h-20h)
     *
     * @return bool
     */
    public function estValideOuverture()
    {
        return $this->date_debut->hour >= 8 && 
               $this->date_debut->hour < 20 && 
               $this->date_fin->hour >= 8 && 
               $this->date_fin->hour <= 20;
    }
    /**
     * Vérifie si la réservation est annulée
     */
    public function isCancelled()
    {
        return $this->statut === 'annulee';
    }

    public function company()
    {
        return $this->salle->company;
    }

    /**
     * Vérifie si la réservation est modifiable
     */
    public function isEditable()
    {
        $reservation = Reservations::findOrFail($id);
        
        $reservation->update([
            'statut' => 'annulé',
            'motif_annulation' => $request->input('motif_annulation'),
            'canceled_by' => Auth::id(),
            'canceled_at' => Carbon::now()
        ]);
    }

    /**
     * Vérifie si la réservation tombe un dimanche ou un jour férié
     *
     * @return bool
     */
    public function estJourExclu()
    {
        if ($this->date_debut->dayOfWeek === Carbon::SUNDAY || 
            $this->date_fin->dayOfWeek === Carbon::SUNDAY) {
            return true;
        }

        return $this->estJourFerie($this->date_debut) || 
               $this->estJourFerie($this->date_fin);
    }

    /**
     * Vérifie si une date donnée est un jour férié
     *
     * @param Carbon $date
     * @return bool
     */
    protected function estJourFerie(Carbon $date)
    {
        $joursFeries = [
            
            $date->copy()->setMonth(1)->setDay(1)->format('Y-m-d'), 
            $date->copy()->setMonth(5)->setDay(1)->format('Y-m-d'), 
            $date->copy()->setMonth(5)->setDay(8)->format('Y-m-d'), 
            $date->copy()->setMonth(7)->setDay(14)->format('Y-m-d'), 
            $date->copy()->setMonth(8)->setDay(15)->format('Y-m-d'), 
            $date->copy()->setMonth(11)->setDay(1)->format('Y-m-d'), 
            $date->copy()->setMonth(11)->setDay(11)->format('Y-m-d'), 
            $date->copy()->setMonth(12)->setDay(25)->format('Y-m-d'), 
        ];
        return in_array($date->format('Y-m-d'), $joursFeries);
    }

    /**
     * Vérifie s'il y a un conflit avec d'autres réservations
     */
/**
 * Vérifie s'il y a un conflit avec d'autres réservations
 * @return array 
 */
public function aConflit()
{
    $conflictingReservation = Reservations::where('salle_id', $this->salle_id)
        ->where('id', '!=', $this->id ?? 0)
        ->whereIn('statut', [self::STATUT_VALIDEE, self::STATUT_EN_ATTENTE])
        ->where(function($query) {
            $query->where(function($q) {
                $q->where('date_debut', '<', $this->date_fin)
                  ->where('date_fin', '>', $this->date_debut);
            });
        })
        ->first(['id', 'objet_reunion', 'date_debut', 'date_fin']);

    return [
        'has_conflict' => $conflictingReservation !== null,
        'conflicting_with' => $conflictingReservation
    ];
}

/**
 * Méthode alternative plus simple pour vérifier les conflits
 * @return bool
 */
public function hasConflict()
{
    return Reservations::where('salle_id', $this->salle_id)
        ->where('id', '!=', $this->id ?? 0)
        ->whereIn('statut', [self::STATUT_VALIDEE, self::STATUT_EN_ATTENTE])
        ->where('date_debut', '<', $this->date_fin)
        ->where('date_fin', '>', $this->date_debut)
        ->exists();
}

/**
 * Récupère les détails de la première réservation en conflit
 * @return Reservations|null
 */
public function getConflictingReservation()
{
    return Reservations::where('salle_id', $this->salle_id)
        ->where('id', '!=', $this->id ?? 0)
        ->whereIn('statut', [self::STATUT_VALIDEE, self::STATUT_EN_ATTENTE])
        ->where('date_debut', '<', $this->date_fin)
        ->where('date_fin', '>', $this->date_debut)
        ->with(['demandeur:id,name', 'salle:id,nom']) 
        ->first();
}


/**
 * Détermine le niveau hiérarchique d'un rôle
 */

 private static function getRoleLevel($role)
{
    // Créer une instance temporaire pour utiliser le trait
    $tempInstance = new class {
        use ChecksUserRole;
    };
    
    return $tempInstance->getRoleLevel($role);
}

/**
 * Fonction principale de validation des réservations
 * Retourne true si validation échoue (pour compatibilité avec votre code)
 * Retourne false si pas de problème
 */
public function durationExceeded(User $user)
{
    try {
       $durationInDays = $this->date_debut->diffInDays($this->date_fin);
    
    if ($durationInDays > 14) {
        $this->validationErrors = [
            'title' => 'Durée maximale dépassée',
            'message' => 'La durée de réservation ne peut pas excéder 2 semaines (14 jours).',
            'icon' => 'fa-calendar-times',
            'type' => 'danger'
        ];
        return true;
    }
    
    return false;
        
    } catch (\Exception $e) {
        Log::error('Erreur validation réservation', [
            'user_id' => $user->id,
            'error' => $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ]);
        $this->validationErrors = ['Erreur lors de la vérification de la réservation'];
        return true; // Échec par sécurité
    }
}

/**
 * Récupère les erreurs de validation détaillées
 */
public function getValidationErrors()
{
    return $this->validationErrors ?? [[
        'title' => 'Erreur de validation',
        'message' => 'La durée de réservation demandée dépasse la limite autorisée pour votre profil.',
        'icon' => 'fa-ban',
        'type' => 'danger'
    ]];
}

public function getReservationDetails()
{
    return [
        'objet' => $this->objet_reunion,
        'date_debut' => $this->date_debut->format('Y-m-d H:i'),
        'date_fin' => $this->date_fin->format('Y-m-d H:i'),
        'nombre_participants' => $this->nombreParticipants,
        'salle_id' => $this->salle_id
    ];
}


/**
 * Vérifie si la réservation est passée
 */
/**
 * Vérifie si la réservation est dans un état qui empêche la validation
 * Retourne true si :
 * - La réservation a commencé (date_debut passée)
 * - La réservation est en cours (entre date_debut et date_fin)
 * - La réservation est terminée (date_fin passée)
 *
 * @return bool
 */
public function isPast()
{
    $now = now();
    if ($this->date_debut->isPast()) {
        return true;
    }
    
    if ($now->between($this->date_debut, $this->date_fin)) {
        return true;
    }
    
    return false;
}

/**
 * Vérifie l'état temporel de la réservation
 * 
 * @return array [
 *     'is_past' => bool,
 *     'status' => 'future'|'started'|'in_progress'|'completed',
 *     'message' => string
 * ]
 */
public function getTimeStatus()
{
    $now = now();
    
    if ($this->date_fin->isPast()) {
        return [
            'is_past' => true,
            'status' => 'completed',
            'message' => 'La réservation est terminée'
        ];
    }
    
    if ($now->between($this->date_debut, $this->date_fin)) {
        return [
            'is_past' => true,
            'status' => 'in_progress',
            'message' => 'La réservation est en cours'
        ];
    }
    
    if ($this->date_debut->isPast()) {
        return [
            'is_past' => true,
            'status' => 'started',
            'message' => 'La réservation a commencé'
        ];
    }
    
    return [
        'is_past' => false,
        'status' => 'future',
        'message' => 'La réservation est à venir'
    ];
}

/**
 * Vérifie si la réservation a commencé mais pas encore terminée
 */
public function isOngoing()
{
    $now = now();
    return $this->date_debut->lte($now) && $this->date_fin->gte($now);
}

/**
 * Vérifie toutes les contraintes de durée
 */
public function validateDuration(User $user)
{
    $errors = [];
    
    // 1. Vérification durée totale
    $durationValidation = $this->durationExceeded($user);
    if ($durationValidation !== false) {
        $errors = array_merge($errors, $this->getValidationErrors());
    }
    
    // 2. Vérification si la réservation est trop courte
    if ($this->date_debut->diffInMinutes($this->date_fin) < 15) {
        $errors[] = [
            'title' => 'Durée trop courte',
            'message' => 'La réservation doit durer au moins 15 minutes.',
            'icon' => 'fa-hourglass-start',
            'type' => 'warning'
        ];
    }
    
    // 3. Vérification si la réservation dépasse minuit
    if (!$this->date_debut->isSameDay($this->date_fin)) {
        $errors[] = [
            'title' => 'Durée sur plusieurs jours',
            'message' => 'Les réservations ne peuvent pas s\'étendre sur plusieurs jours.',
            'icon' => 'fa-calendar-alt',
            'type' => 'danger'
        ];
    }   
    
    return empty($errors) ? true : $errors;
}

    public function scopeValide($query)
    {
        return $query->where('statut', 'validé');
    }
    
    public function scopeEnAttente($query)
    {
        return $query->where('statut', 'en_attente');
    }
    
    public function scopeAnnule($query)
    {
        return $query->where('statut', 'annulé');
    }
    
    public function scopeAVenir($query)
    {
        $now = Carbon::now();
        return $query->whereDate('date_debut', '>=', $now->toDateString())
            ->orWhere(function($q) use ($now) {
                $q->whereDate('date_debut', '=', $now->toDateString())
                  ->whereTime('heure_debut', '>=', $now->format('H:i:s'));
            });
    }
    
    public function scopeAvecRappelActif($query)
    {
        return $query->where('rappel_active', true)
                    ->whereNull('rappel_envoye_at');
    }
    
    public function scopeRappelsImminents($query)
    {
        $now = Carbon::now();
        $thirtyMinutesLater = Carbon::now()->addMinutes(30);
        
        return $query->valide() 
                    ->avecRappelActif()
                    ->whereDate('date_debut', '=', $now->toDateString()) 
                    ->whereTime('heure_debut', '>=', $now->format('H:i:s')) 
                    ->whereTime('heure_debut', '<=', $thirtyMinutesLater->format('H:i:s')); 
    }
  
    public function getStatutBadgeAttribute()
    {
        $badges = [
            'en attente' => '<span class="badge bg-warning">En attente</span>',
            'validé' => '<span class="badge bg-success">Validé</span>',
            'annulé' => '<span class="badge bg-danger">Annulé</span>'
        ];
        
        return $badges[$this->statut] ?? '<span class="badge bg-secondary">Inconnu</span>';
    }
    
    public function getEstPasseeAttribute()
    {
        $now = Carbon::now();
        $dateHeureFin = Carbon::parse($this->date_fin->format('Y-m-d') . ' ' . $this->heure_fin->format('H:i:s'));
        
        return $dateHeureFin->lt($now);
    }
    
    public function getEstEnCoursAttribute()
    {
        $now = Carbon::now();
        $dateHeureDebut = Carbon::parse($this->date_debut->format('Y-m-d') . ' ' . $this->heure_debut->format('H:i:s'));
        $dateHeureFin = Carbon::parse($this->date_fin->format('Y-m-d') . ' ' . $this->heure_fin->format('H:i:s'));
        
        return $dateHeureDebut->lte($now) && $dateHeureFin->gte($now);
    }
    
    public function getDureeFormatteeAttribute()
    {
        $dateHeureDebut = Carbon::parse($this->date_debut->format('Y-m-d') . ' ' . $this->heure_debut->format('H:i:s'));
        $dateHeureFin = Carbon::parse($this->date_fin->format('Y-m-d') . ' ' . $this->heure_fin->format('H:i:s'));
        
        $diffMinutes = $dateHeureFin->diffInMinutes($dateHeureDebut);
        $heures = floor($diffMinutes / 60);
        $minutes = $diffMinutes % 60;
        
        $resultat = [];
        if ($heures > 0) {
            $resultat[] = $heures . ' h';
        }
        if ($minutes > 0 || count($resultat) == 0) {
            $resultat[] = $minutes . ' min';
        }
        
        return implode(' ', $resultat);
    }

}
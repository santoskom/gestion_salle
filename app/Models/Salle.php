<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Salle extends Model
{

 protected $fillable = [
    'nom',
    'capacite',
    'localisation',
    'description',
    'company_id',
    'disponible',
    'equipements',
    'visioconference',
];


protected $casts = [
    
    'equipements' => 'array', 
];



 public function reservations()
 {
     return $this->hasMany(Reservation::class, 'salle_id');
 }


 
  public function isDisponible($dateDebut, $dateFin)
  {
      return !$this->reservations()
          ->whereIn('statut', [Reservation::STATUT_VALIDEE, Reservation::STATUT_EN_ATTENTE])
          ->where(function ($query) use ($dateDebut, $dateFin) {
              $query->whereBetween('date_debut', [$dateDebut, $dateFin])
                  ->orWhereBetween('date_fin', [$dateDebut, $dateFin])
                  ->orWhere(function ($q) use ($dateDebut, $dateFin) {
                      $q->where('date_debut', '<=', $dateDebut)
                          ->where('date_fin', '>=', $dateFin);
                  });
          })
          ->exists();
          
  }

  public function company()
  {
      return $this->belongsTo(Company::class);
  }
}

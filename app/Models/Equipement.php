<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Equipement extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'numero_serie',
        'marque',
        'modele',
    ];

    public function reservations()
{
    return $this->belongsToMany(Reservations::class, 'equipement_reservation', 'equipement_id', 'reservation_id');
}

}

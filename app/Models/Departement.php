<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Departement extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'responsable',
        'telephone',
        'localisation',
        'company_id'
    ];

    public function user()
    {
        return $this->hasMany(User::class);
    }

    public function company()
    {
        return $this->belongsTo(company::class);
    }
}

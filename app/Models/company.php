<?php

namespace App\Models;

use App\Models\Salle;
use Illuminate\Database\Eloquent\Model;

class Company  extends Model
{ protected $table = 'company'; 
    protected $fillable = [
        'name',
        'address',
        'phone',
        'email',
        'logo'
    ];

    public function departments()
    {
        return $this->hasMany(Departement::class);
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }

    public function Salles()
    {
        return $this->hasMany(Salle::class);
    } 

}

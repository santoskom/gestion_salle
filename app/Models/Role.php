<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    protected $fillable= [ 
        'nom'
    ]; 
   public function user()
{
    return $this->hasMany(User::class, 'id_role');
}
}

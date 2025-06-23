<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Permission extends Model
{
    use HasFactory;
    protected $fillable= [ 
        'nom'
    ]; 

    
    public function user()
    {
        return $this->hasMany(User::class,'id_permission');
    }
}

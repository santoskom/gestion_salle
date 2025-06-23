<?php

namespace App\Models;

use App\Models\Role;
use App\Traits\AdminCompany;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable;
 use AdminCompany;
    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'matricule',
        'departement_id',
        'id_role',
        'company_id',
        'receive_notifications',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
    
    public function isAssistantDirection()
    {
        $roleAssistant = Role::where('nom', 'Assistant de directions')->first();
        
        if (!$roleAssistant) {
            return false;
        }
        
        return $this->role_id === $roleAssistant->id;
    }

    /**
     * Reservations demandées par l'utilisateur
     */
    public function reservations()
    {
        return $this->hasMany(Reservations::class, 'id_demandeur');
    }


    public function departement()
    {
        return $this->belongsTo(Departement::class);
    }
    
 public function roles()
{
    return $this->belongsTo(Role::class, 'id_role');
}

    /**
 * Vérifie si l'utilisateur a un rôle spécifique
 */
public function hasRole(string $role): bool
{
    return $this->role && $this->role->nom === $role;
}

    public function permissions()
    {
        return $this->belongsToMany(Permission::class, 'user_permission', 'user_id', 'id_permission');
    }


    public function reservationsCreees()
    {
        return $this->hasMany(Reservations::class, 'id_createur');
    }

    public function isAdmin()
{
    return $this->hasRole('Administrateur Système'); 
}


  
    public function availableRooms()
    {
        if ($this->hasRole('assistant de direction')) {
            return Salle::where('company_id', $this->department->company_id)->get();
        }
        if ($this->hasRole('Administrateur Système')) {
            return Salle::all();
        }
        
        return Salle::where('company_id', $this->department->company_id)->get();
    }
        public function company()
            {
                return $this->belongsTo(company::class, 'company_id');
            }
}

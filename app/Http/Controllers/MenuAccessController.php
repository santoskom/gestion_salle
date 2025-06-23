<?php

namespace App\Http\Controllers;

use App\Traits\ChecksUserRole;
use Illuminate\Http\Request;

class MenuAccessController extends Controller
{
    use ChecksUserRole;
    
    /**
     * Vérifie si l'utilisateur peut accéder au menu d'administration
     */
   /**
     * Vérifie si l'utilisateur peut accéder au menu d'administration
     */
    public function canAccessAdminMenu(): bool
    {
        return $this->userHasAnyRole(['Administrateur Système', 'Assistant de directions']);
    }
    
    /**
     * Vérifie si l'utilisateur est administrateur
     */
    public function isAdmin(): bool
    {
        return $this->userHasRole('Administrateur Système');
    }
    
    /**
     * Vérifie si l'utilisateur est assistant de direction
     */
    public function isAssistantDirecteur(): bool
    {
        return $this->userHasRole('Assistant de directions');
    }
    
    /**
     * Obtient le nom du rôle de l'utilisateur connecté
     */
    public function getUserRoleName(): ?string
    {
        $user = auth()->user();
        
        if (!$user) {
            return null;
        }
        
        $role = \App\Models\Role::find($user->id_role);
        
        return $role?->nom;
    }
}
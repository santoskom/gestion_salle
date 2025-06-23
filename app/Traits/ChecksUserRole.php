<?php

namespace App\Traits;

use Illuminate\Http\Request;
use App\Models\Role;
use App\Models\Permission;

trait ChecksUserRole
{
    
    /**
     * Vérifie si l'utilisateur a le rôle spécifié
     */
    protected function userHasRole(string $role): bool
    {
        $user = auth()->user();
        
        if (!$user) {
            return false;
        }
        
        return $user->id_role === $this->getRoleId($role);
    }
    
    /**
     * Vérifie si l'utilisateur a l'un des rôles spécifiés
     */
    protected function userHasAnyRole(array $roles): bool
    {
        foreach ($roles as $role) {
            if ($this->userHasRole($role)) {
                return true;
            }
        }
        
        return false;
    }
    
    /**
     * Obtient l'ID du rôle depuis la base de données
     */
    protected function getRoleId(string $roleName): ?int
    {
        $role = Role::where('nom', $roleName)->first();
        
        return $role?->id;
    }
    
    /**
     * Vérifie si l'utilisateur a la permission spécifiée
     */
    protected function userHasPermission(string $permission): bool
    {
        $user = auth()->user();
        
        if (!$user) {
            return false;
        }
        
        // Si relation many-to-many
        return $user->permissions()->where('nom', $permission)->exists();
    }
    
    /**
     * Obtient l'ID de la permission depuis la base de données
     */
    protected function getPermissionId(string $permissionName): ?int
    {
        $permission = Permission::where('nom', $permissionName)->first();
        
        return $permission?->id;
    }
    
    /**
     * Vérifie si l'utilisateur connecté est administrateur ou Assistant de directions
     */
    public function canAccessAdminMenu(): bool
    {
        return $this->userHasAnyRole(['Administrateur Système', 'Assistant de directions']);
    }
    
    /**
     * Vérifie si l'utilisateur connecté est administrateur
     */
    public function isAdmin(): bool
    {
        return $this->userHasRole('Administrateur Système');
    }
    
    /**
     * Vérifie si l'utilisateur connecté est assistant de direction
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
        
        $role = Role::find($user->id_role);
        
        return $role?->nom;
    }
    
    // NOUVEAUX RÔLES AJOUTÉS
    
    /**
     * Vérifie si l'utilisateur est PDG/Président
     */
    public function isPDG(): bool
    {
        return $this->userHasAnyRole(['PDG', 'Président Général', 'Directeur Général']);
    }
    
    /**
     * Vérifie si l'utilisateur est directeur
     */
    public function isDirecteur(): bool
    {
        return $this->userHasAnyRole([
            'Directeur', 'Directrice', 'Directeur Commercial', 
            'Directeur Technique', 'Directeur Marketing', 
            'Directeur RH', 'Directeur Financier', 
            'Directeur Opérationnel', 'Directeur Production'
        ]);
    }
    
    /**
     * Vérifie si l'utilisateur est manager
     */
    public function isManager(): bool
    {
        return $this->userHasAnyRole([
            'Chef de Service', 'Responsable', 'Manager', 
            'Superviseur', 'Chef d\'Équipe', 'Coordinateur'
        ]);
    }
    
    /**
     * Vérifie si l'utilisateur est employé standard
     */
    public function isEmploye(): bool
    {
        return $this->userHasRole('Employé');
    }
    
    /**
     * NOUVELLE FONCTION: Détermine le niveau hiérarchique d'un rôle depuis la BD
     */
    public function getRoleLevel(?string $roleName = null): int
    {
        // Si pas de rôle spécifié, utilise celui de l'utilisateur connecté
        if (!$roleName) {
            $roleName = $this->getUserRoleName();
        }
        
        if (!$roleName) {
            return 1; // Niveau par défaut
        }
        
        $roleLower = strtolower(trim($roleName));
        
        // Mapping des rôles de la BD vers les niveaux hiérarchiques
        $roleHierarchy = [
            // Niveau 5 - Direction générale
            'pdg' => 5,
            'président général' => 5,
            'president general' => 5,
            'président' => 5,
            'directeur général' => 5,
            'directeur general' => 5,
            'dg' => 5,
            
            // Niveau 4 - Direction
            'directeur' => 4,
            'directrice' => 4,
            'directeur commercial' => 4,
            'directeur technique' => 4,
            'directeur marketing' => 4,
            'directeur rh' => 4,
            'directeur financier' => 4,
            'directeur opérationnel' => 4,
            'directeur production' => 4,
            
            // Niveau 3 - Assistance direction
            'assistant de direction' => 3,
            'assistant de directions' => 3,
            'assistant directeur' => 3,
            'adjoint directeur' => 3,
            'chef de cabinet' => 3,
            
            // Niveau 2 - Management intermédiaire
            'chef de service' => 2,
            'responsable' => 2,
            'manager' => 2,
            'superviseur' => 2,
            'chef d\'équipe' => 2,
            'chef d equipe' => 2,
            'coordinateur' => 2,
            'administrateur système' => 2, // Ajout pour votre cas
            
            // Niveau 1 - Employé standard
            'employé' => 1,
            'employe' => 1,
        ];
        
        // Recherche exacte
        if (isset($roleHierarchy[$roleLower])) {
            return $roleHierarchy[$roleLower];
        }
        
        // Recherche partielle pour les rôles composés
        foreach ($roleHierarchy as $roleKey => $level) {
            if (strpos($roleLower, $roleKey) !== false || strpos($roleKey, $roleLower) !== false) {
                return $level;
            }
        }
        
        // Recherche par mots-clés critiques
        $criticalKeywords = ['pdg', 'président', 'directeur général', 'dg'];
        foreach ($criticalKeywords as $keyword) {
            if (strpos($roleLower, $keyword) !== false) {
                return 5;
            }
        }
        
        $directionKeywords = ['directeur', 'directrice'];
        foreach ($directionKeywords as $keyword) {
            if (strpos($roleLower, $keyword) !== false) {
                return 4;
            }
        }
        
        $assistantKeywords = ['assistant'];
        foreach ($assistantKeywords as $keyword) {
            if (strpos($roleLower, $keyword) !== false) {
                return 3;
            }
        }
        
        $managerKeywords = ['chef', 'responsable', 'manager', 'superviseur', 'coordinateur'];
        foreach ($managerKeywords as $keyword) {
            if (strpos($roleLower, $keyword) !== false) {
                return 2;
            }
        }
        
        return 1; // Employé standard par défaut
    }
    
    /**
     * Obtient le niveau hiérarchique de l'utilisateur connecté
     */
    public function getCurrentUserLevel(): int
    {
        return $this->getRoleLevel();
    }
    
    /**
     * Vérifie si l'utilisateur a un niveau hiérarchique minimum
     */
    public function hasMinimumLevel(int $minimumLevel): bool
    {
        return $this->getCurrentUserLevel() >= $minimumLevel;
    }
}

<?php

namespace App\Traits;

use App\Models\Role;

trait ChecksAdminRole
{
    /**
     * Vérifie si l'utilisateur a le rôle d'administrateur
     */
    protected function userIsAdmin(): bool
    {
        $user = auth()->user();

        if (!$user) {
            return false;
        }

        return $user->id_role === $this->getRoleId('Administrateur de  Système');
    }

    /**
     * Obtient l'ID du rôle depuis la base de données
     */
    protected function getRoleId(string $roleName): ?int
    {
        $role = Role::where('nom', $roleName)->first();

        return $role?->id; 
    }
}
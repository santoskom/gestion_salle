<?php
namespace App\Traits;

use App\Models\company;

trait AdminCompany
{
    public function attachToAllCompanies()
    {
        if ($this->role->nom === 'Administrateur de systeme') { // Adaptez à votre structure de rôles
            $companies = company::all();
            $this->companies()->sync($companies->pluck('id'));
        }
    }
}
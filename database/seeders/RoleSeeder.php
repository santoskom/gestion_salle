<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // \App\Models\Role::create(['nom' => 'Administrateur Système']);
        // \App\Models\Role::create(['nom' => 'Assistant de directions']);
        // \App\Models\Role::create(['nom' => 'DEMANDEUR']);
        \App\Models\Role::insert([
            ['nom' => 'Administrateur Système'],
            ['nom' => 'Assistant de directions'],
            ['nom' => 'DEMANDEUR'],
        ]);
    }
}

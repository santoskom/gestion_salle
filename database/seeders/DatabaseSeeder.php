<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
public function run(): void
{
    $this->call([
        CompanySeeder::class,
        DepartementSeeder::class,
        RoleSeeder::class,
        EquipementSeeder::class,
        SalleSeeder::class,
        UserSeeder::class,
        ReservationSeeder::class,
    ]);
}

}

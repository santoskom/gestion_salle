<?php

namespace Database\Factories;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Reservations>
 */
class ReservationFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
     public function definition(): array
    {
        $start = Carbon::now()->addDays(rand(1, 10));
        $end = (clone $start)->addHours(rand(1, 3));

        return [
            'salle_id' => 1,
            'id_demandeur' => 1,
            'id_createur' => 1,
            'objet_reunion' => $this->faker->sentence(3),
            'description' => $this->faker->paragraph(),
            'date_debut' => $start,
            'date_fin' => $end,
            'statut' => $this->faker->randomElement(['en_attente', 'validee', 'refusee', 'annulee']),
            'nombreParticipants' => rand(2, 20),
            'rappel_active' => $this->faker->boolean(),
        ];
    }
}

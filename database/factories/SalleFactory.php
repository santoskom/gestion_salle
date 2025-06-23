<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Salle>
 */
class SalleFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
  public function definition(): array
    {
        return [
            'nom' => 'Salle ' . $this->faker->word(),
            'capacite' => rand(10, 100),
            'localisation' => $this->faker->address(),
            'description' => $this->faker->sentence(),
            'company_id' => 1,
            'disponible' => true,
            'equipements' => 'tableau, projecteur',
            'visioconference' => $this->faker->boolean(),
        ];
    }
}

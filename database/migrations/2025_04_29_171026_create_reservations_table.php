<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('reservations', function (Blueprint $table) {
        
            $table->id();
            $table->unsignedBigInteger('salle_id');
            $table->unsignedBigInteger('id_demandeur')->nullable(); // Utilisateur qui demande la salle
            $table->unsignedBigInteger('id_createur')->nullable(); // Assistant de direction qui valide
            $table->string('objet_reunion');
            $table->text('description')->nullable();
            $table->date('date_debut');
            $table->date('date_fin');
            $table->time('heure_debut');
            $table->time('heure_fin');
            $table->enum('statut', ['en_attente', 'valide', 'annulee'])->default('en_attente');
            $table->integer('nombreParticipants');
            $table->boolean('rappel_active')->default(false);
            $table->timestamps();

            // Clés étrangères
            $table->foreign('salle_id')->references('id')->on('salles')->onDelete('cascade');
            $table->foreign('id_demandeur')->references('id')->on('users')->onDelete('set null');
            $table->foreign('id_createur')->references('id')->on('users')->onDelete('set null');
        });

      // Table pivot pour les équipements
      Schema::create('equipement_reservation', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('reservation_id');
        $table->unsignedBigInteger('equipement_id');
        $table->foreign('reservation_id')->references('id')->on('reservations')->onDelete('cascade');
        $table->foreign('equipement_id')->references('id')->on('equipements')->onDelete('restrict');
        $table->unique(['reservation_id', 'equipement_id']);
    });
}


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('equipement_reservation');
        Schema::dropIfExists('reservations');
    }
};

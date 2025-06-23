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
        Schema::create('departements', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
    
            // Champs supplémentaires en nullable
            $table->string('description')->nullable();
            $table->string('responsable')->nullable(); // Responsable du département
            $table->string('telephone')->nullable();
            $table->string('localisation')->nullable(); // Ex : bâtiment, étage...
            $table->foreignId('company_id')->constrained()->onDelete('cascade');
            $table->timestamps(); // cree_le, modifie_le
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('departements');
    }
};

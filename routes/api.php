<?php

use App\Http\Controllers\ReservationController;


// Route::middleware(['auth:sanctum'])->group(function () {
//     Route::get('/reservations/salle/{salle_id}', [ReservationController::class, 'getReservationsBySalle']);
//     Route::post('/reservations/check-conflicts', [ReservationController::class, 'checkConflicts']);
// });
 Route::get('/reservations', [App\Http\Controllers\ReservationController::class, 'getReservationsForCalendar'])
    ->name('api.reservations');

  // API Routes pour FullCalendar
    Route::prefix('api/reservations')->group(function () {
        // Récupération des événements
        Route::get('/events', [ReservationController::class, 'getEvents'])->name('reservations.events');
        
        // Création d'une réservation
        Route::post('/', [ReservationController::class, 'store'])->name('reservations.store');
        
        // Mise à jour d'une réservation (drag & drop, resize)
        Route::put('/{id}', [ReservationController::class, 'update'])->name('reservations.update');
        
        // Suppression d'une réservation
        Route::delete('/{id}', [ReservationController::class, 'destroy'])->name('reservations.destroy');
        
        // Récupération des salles disponibles
        Route::get('/salles', [ReservationController::class, 'getSalles'])->name('reservations.salles');
    });

    
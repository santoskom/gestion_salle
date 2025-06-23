<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\AppController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ComponyController;
use App\Http\Controllers\DepartementController;
use App\Http\Controllers\EquipementsController;
use App\Http\Controllers\NotificationApiController;
use App\Http\Controllers\PasswordResetController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\PlanningController;
use App\Http\Controllers\ReservationController;
use App\Http\Controllers\ReservationsController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\RservationController;
use App\Http\Controllers\SalleController;
use App\Http\Controllers\StatReservationsRefuseesController;
use App\Http\Controllers\statsController;
use Illuminate\Support\Facades\Route;






Route::get('/forgot-password', [PasswordResetController::class, 'showForm'])->name('password.request');
Route::post('/forgot-password', [PasswordResetController::class, 'handle'])->name('password.email');

Route::get('/', [AuthController::class, 'login'])->name('login');
Route::post('/', [AuthController::class, 'handleLogin'])->name('handleLogin');





Route::middleware('auth')->group(function () {
    Route::get('dashbord', [AppController::class, 'index'])->name('dashbord');
    Route::get('stats', [statsController::class, 'index'])->name('stats');



    Route::get('/mon-profil', function () {
        return view('profile.modal', ['user' => auth()->user()]);
    })->middleware('auth');


    Route::prefix('departements')->group(function () {
        Route::get('/', [DepartementController::class, 'index'])->name('departements.index');

        Route::get('/create', [DepartementController::class, 'create'])->name('departements.create');

        Route::post('/create', [DepartementController::class, 'store'])->name('departements.store');

        Route::get('/edit/{departement}', [
            DepartementController::class,
            'edit'
        ])->name('departements.edit');

        Route::put('/update/{departement}', [
            DepartementController::class,
            'update'
        ])->name('departements.update');


        Route::get('/{departement}', [DepartementController::class, 'delete'])->name('departements.delete');
    });


    Route::prefix('equipements')->group(function () {
        Route::get('/', [EquipementsController::class, 'index'])->name('equipements.index');

        Route::get('/create', [EquipementsController::class, 'create'])->name('equipements.create');

        Route::post('/create', [EquipementsController::class, 'store'])->name('equipements.store');

        Route::get('/edit/{equipement}', [
            EquipementsController::class,
            'edit'
        ])->name('equipements.edit');

        Route::put('/update/{equipement}', [
            EquipementsController::class,
            'update'
        ])->name('equipements.update');


        Route::delete('/equipements/{id}', [EquipementsController::class, 'destroy'])->name('equipements.delete');
    });

    Route::prefix('salles')->group(function () {
        Route::get('/', [SalleController::class, 'index'])->name('salles.index');

        Route::get('/create', [SalleController::class, 'create'])->name('salles.create');

        Route::post('/create', [SalleController::class, 'store'])->name('salles.store');

        Route::get('/edit/{salle}', [
            SalleController::class,
            'edit'
        ])->name('salles.edit');

        Route::put('/update/{salle}', [
            SalleController::class,
            'update'
        ])->name('salles.update');


        Route::get('/{salle}', [SalleController::class, 'delete'])->name('salles.delete');
    });

    // Routes pour les réservations
    Route::middleware(['auth'])->group(function () {

        Route::get('/reservations/en-attente', [ReservationsController::class, 'Pending'])
            ->name('reservations.en-attente');


        Route::patch('/reservations/{reservation}/valider', [ReservationsController::class, 'validate'])
            ->name('reservations.valider');

        Route::post('/reservations/validated', [ReservationController::class, 'validateReservation'])
            ->name('reservations.validated');

        Route::get('/reservations/salle', [ReservationsController::class, 'getReservationsBySalle']);
        Route::post('/reservations/check-conflicts', [ReservationsController::class, 'checkConflicts']);
        Route::patch('/reservations/{reservation}/refuser', [ReservationsController::class, 'refuse'])
            ->name('reservations.refuser');


        Route::get('/reservations/export', [ReservationsController::class, 'export'])
            ->name('reservations.export');
        Route::get('/reservations/search', [ReservationsController::class, 'search'])->name('reservations.search');
        //supprission mutiple 
        Route::delete('reservations/mass-destroy', [ReservationsController::class, 'massDestroy'])
            ->name('reservations.massDestroy');
        Route::resource('reservations', ReservationsController::class);


        Route::get('/planning', [PlanningController::class, 'index'])->name('planning.index');
        Route::get('/planning/export-pdf', [PlanningController::class, 'exportPdf'])->name('planning.export-pdf');
        Route::post('/planning/send-email', [PlanningController::class, 'sendEmail'])->name('planning.send-email');
    });




    // routes/web.php



    Route::middleware(['auth'])->group(function () {
        // Route principale pour afficher le calendrier

        Route::get('/glissez', [ReservationController::class, 'index'])->name('glissez.index');

        // API Routes pour FullCalendar
        Route::get('/api/reservations', [ReservationController::class, 'getEvents'])->name('api.reservations.events');
        Route::post('/api/reservations', [ReservationController::class, 'store'])->name('api.reservations.store');
        Route::put('/api/reservations/{reservation}', [ReservationController::class, 'update'])->name('api.reservations.update');
        Route::delete('/api/reservations/{reservation}', [ReservationController::class, 'destroy'])->name('api.reservations.destroy');

        // Route pour la mise à jour par glisser-déposer
        Route::patch('/api/reservations/{reservation}/move', [ReservationController::class, 'move'])->name('api.reservations.move');

        // Route pour obtenir les statistiques
        Route::get('/api/reservations/stats', [ReservationController::class, 'getStats'])->name('api.reservations.stats');

        // Route pour vérifier les conflits
        Route::post('/api/reservations/check-conflict', [ReservationController::class, 'checkConflict'])->name('api.reservations.check-conflict');
    });


    Route::prefix('roles')->group(function () {
        Route::get('/', [RoleController::class, 'index'])->name('roles.index');

        Route::get('/create', [RoleController::class, 'create'])->name('roles.create');

        Route::post('/create', [RoleController::class, 'store'])->name('roles.store');

        Route::get('/edit/{roles}', [
            RoleController::class,
            'edit'
        ])->name('roles.edit');

        Route::put('/update/{role}', [
            RoleController::class,
            'update'
        ])->name('roles.update');

        Route::get('/{role}', [RoleController::class, 'delete'])->name('roles.delete');
    });

    Route::prefix('admins')->group(function () {

        Route::get('/', [AdminController::class, 'index'])->name('admins.index');

        Route::get('/create', [AdminController::class, 'create'])->name('admins.create');

        Route::post('/create', [AdminController::class, 'store'])->name('admins.store');

        Route::get('/edit/{user}', [
            AdminController::class,
            'edit'
        ])->name('admins.edit');

        Route::put('/update/{user}', [
            AdminController::class,
            'update'
        ])->name('admins.update');

        Route::get('/{user}', [AdminController::class, 'delete'])->name('admins.delete');
    });

    Route::prefix('permissions')->group(function () {
        Route::get('/', [PermissionController::class, 'index'])->name('permissions.index');

        Route::get('/create', [PermissionController::class, 'create'])->name('permissions.create');

        Route::post('/create', [PermissionController::class, 'store'])->name('permissions.store');

        Route::get('/edit/{permissions}', [
            PermissionController::class,
            'edit'
        ])->name('permissions.edit');

        Route::put('/update/{permission}', [
            PermissionController::class,
            'update'
        ])->name('permissions.update');

        Route::get('/{permission}', [PermissionController::class, 'delete'])->name('permissions.delete');
    });


    // Routes de notifications
    Route::middleware(['auth'])->group(function () {
        Route::get('/notifications', [App\Http\Controllers\NotificationApiController::class, 'index'])->name('notifications.index');
        Route::get('/notifications/count', [App\Http\Controllers\NotificationApiController::class, 'getUnreadCount'])->name('notifications.count');
        Route::post('/notifications/{id}/read', [App\Http\Controllers\NotificationApiController::class, 'markAsRead'])->name('notifications.read');
        Route::post('/notifications/read-all', [App\Http\Controllers\NotificationApiController::class, 'markAllAsRead'])->name('notifications.readAll');
        Route::delete('/notifications/{id}', [App\Http\Controllers\NotificationApiController::class, 'destroy'])->name('notifications.destroy');
    });

    Route::middleware(['auth'])->prefix('api')->group(function () {
        Route::get('/reservations/salle', [ReservationsController::class, 'getReservationsBySalle']);
        Route::post('/reservations/check-conflicts', [ReservationsController::class, 'checkConflicts']);
    });





    Route::prefix('companys')->group(function () {
        Route::get('/', [ComponyController::class, 'index'])->name('companys.index');

        Route::get('/create', [ComponyController::class, 'create'])->name('companys.create');
        Route::post('/create', [ComponyController::class, 'store'])->name('companys.store');

        Route::get('/edit/{company}', [ComponyController::class, 'edit'])->name('companys.edit');
        Route::put('/update/{company}', [ComponyController::class, 'update'])->name('companys.update');

        Route::get('/{company}', [ComponyController::class, 'show'])->name('companys.show');
        Route::delete('/{company}', [ComponyController::class, 'destroy'])->name('companys.destroy');
    });
});

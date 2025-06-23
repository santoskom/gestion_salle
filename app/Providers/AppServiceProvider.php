<?php

namespace App\Providers;

use App\Traits\ChecksUserRole;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    use ChecksUserRole;
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Paginator::useBootstrapFive();
        Paginator::useBootstrapFour();

       // Directive pour vérifier si l'utilisateur est administrateur ou assistant de direction
       Blade::directive('adminOrAssistant', function () {
        return "<?php if(app()->make('App\Http\Controllers\MenuAccessController')->canAccessAdminMenu()): ?>";
    });

    Blade::directive('endadminOrAssistant', function () {
        return "<?php endif; ?>";
    });
    
    // Directive pour vérifier si l'utilisateur est administrateur uniquement
    Blade::directive('admin', function () {
        return "<?php if(app()->make('App\Http\Controllers\MenuAccessController')->isAdmin()): ?>";
    });

    Blade::directive('endadmin', function () {
        return "<?php endif; ?>";
    });
    
    // Directive pour vérifier si l'utilisateur est assistant de direction uniquement
    Blade::directive('assistant', function () {
        return "<?php if(app()->make('App\Http\Controllers\MenuAccessController')->isAssistantDirecteur()): ?>";
    });

    Blade::directive('endassistant', function () {
        return "<?php endif; ?>";
    });
    
    // Partage les méthodes de vérification de rôle avec toutes les vues
    view()->composer('*', function ($view) {
        $menuController = app()->make('App\Http\Controllers\MenuAccessController');
        $view->with([
            'isAdmin' => function() use ($menuController) {
                return $menuController->isAdmin();
            },
            'isAssistant' => function() use ($menuController) {
                return $menuController->isAssistantDirecteur();
            },
            'canAccessAdminMenu' => function() use ($menuController) {
                return $menuController->canAccessAdminMenu();
            },
            'userRoleName' => function() use ($menuController) {
                return $menuController->getUserRoleName();
            }
        ]);
    });
}
}


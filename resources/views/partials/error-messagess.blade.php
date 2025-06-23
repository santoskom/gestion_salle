@php
    // Fonction pour formater les messages d'erreur techniques en messages utilisateur
    function formatErrorMessage($error) {
        $userFriendlyMessages = [
            // Erreurs de validation des heures
            'La réservation ne respecte pas les heures d\'ouverture (8h-20h)' => [
                'title' => 'Horaires non autorisés',
                'message' => 'Les réservations ne sont possibles que de 8h00 à 20h00.',
                'icon' => 'fa-clock',
                'type' => 'warning'
            ],
            
            // Erreurs de jours exclus
            'Les réservations ne sont pas autorisées les dimanches et jours fériés' => [
                'title' => 'Jour non autorisé',
                'message' => 'Les réservations ne sont pas possibles les dimanches et jours fériés.',
                'icon' => 'fa-calendar-times',
                'type' => 'warning'
            ],
            
            // Erreurs de permission
            'Seuls les assistants de direction peuvent valider les réservations.' => [
                'title' => 'Permission refusée',
                'message' => 'Vous n\'avez pas les droits nécessaires pour valider cette réservation.',
                'icon' => 'fa-user-lock',
                'type' => 'danger'
            ],
            
            // Erreurs d'entreprise
            'Cette réservation ne concerne pas votre entreprise.' => [
                'title' => 'Accès interdit',
                'message' => 'Cette réservation appartient à une autre entreprise.',
                'icon' => 'fa-building-lock',
                'type' => 'danger'
            ],
            
            // Erreurs de statut
            'Cette réservation a déjà été traitée.' => [
                'title' => 'Action impossible',
                'message' => 'Cette réservation a déjà été validée ou refusée.',
                'icon' => 'fa-calendar-check',
                'type' => 'warning'
            ],
            
            // Erreurs de temps - réservation terminée
            'Impossible de valider une réservation déjà terminée' => [
                'title' => 'Réservation terminée',
                'message' => 'Cette réservation est déjà terminée, impossible de la valider.',
                'icon' => 'fa-calendar-times',
                'type' => 'danger'
            ],
            
            // Erreurs de temps - réservation commencée
            'Impossible de valider une réunion déjà commencée' => [
                'title' => 'Réunion en cours',
                'message' => 'Cette réservation a déjà commencé, validation impossible.',
                'icon' => 'fa-running',
                'type' => 'warning'  
            ],
            
            // Erreurs de conflit
            'Ce créneau est déjà réservé' => [
                'title' => 'Créneau indisponible',
                'message' => 'Ce créneau horaire est déjà réservé par quelqu\'un d\'autre.',
                'icon' => 'fa-exclamation-triangle',
                'type' => 'danger'
            ],
            
            // Erreurs de capacité
            'La capacité de la salle est dépassée' => [
                'title' => 'Capacité insuffisante',
                'message' => 'Le nombre de participants dépasse la capacité maximale de la salle.',
                'icon' => 'fa-users',
                'type' => 'danger'
            ],
            
            // Erreurs de durée
            'La durée de réservation demandée dépasse la limite autorisée' => [
                'title' => 'Durée trop longue',
                'message' => 'La durée de votre réservation dépasse les limites autorisées pour votre profil.',
                'icon' => 'fa-hourglass-end',
                'type' => 'warning'
            ],
            
            // Erreurs d'accès
            'Vous n\'avez pas accès à cette salle' => [
                'title' => 'Accès refusé',
                'message' => 'Vous n\'êtes pas autorisé à réserver cette salle.',
                'icon' => 'fa-ban',
                'type' => 'danger'
            ],
            
            // Salle inappropriée
            'Vous réservez une grande salle pour peu de personnes' => [
                'title' => 'Salle inadaptée',
                'message' => 'Une salle plus petite serait plus appropriée.',
                'icon' => 'fa-door-open',
                'type' => 'warning'
            ],
            
            // Durée minimale
            'La réservation doit durer au moins 15 minutes' => [
                'title' => 'Durée trop courte',
                'message' => 'La durée minimale est de 15 minutes.',
                'icon' => 'fa-hourglass-start',
                'type' => 'warning'
            ],
            
            // Plusieurs jours
            'Les réservations ne peuvent pas s\'étendre sur plusieurs jours' => [
                'title' => 'Durée sur plusieurs jours',
                'message' => 'La réservation doit commencer et finir le même jour.',
                'icon' => 'fa-calendar-day',
                'type' => 'danger'
            ],
            
            // Erreur technique
            'Une erreur inattendue est survenue lors de la validation.' => [
                'title' => 'Erreur technique',
                'message' => 'Un problème technique est survenu. Veuillez réessayer.',
                'icon' => 'fa-bug',
                'type' => 'danger'
            ],
        ];
        
        // Chercher un message correspondant exact d'abord
        if (isset($userFriendlyMessages[$error])) {
            return $userFriendlyMessages[$error];
        }
        
        // Chercher par contenu partiel
        foreach ($userFriendlyMessages as $pattern => $format) {
            if (str_contains($error, $pattern)) {
                return $format;
            }
        }
        
        // Gestion spéciale pour les conflits détaillés
        if (str_contains($error, 'Conflit avec la réservation')) {
            return [
                'title' => 'Conflit de réservation',
                'message' => $error,
                'icon' => 'fa-calendar-alt',
                'type' => 'danger'
            ];
        }
        
        // Message par défaut pour les erreurs non reconnues
        return [
            'title' => 'Erreur de validation',
            'message' => $error,
            'icon' => 'fa-exclamation-circle',
            'type' => 'danger'
        ];
    }
@endphp

{{-- Affichage des messages de succès --}}
@if(session('succes_message'))
    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
        <div class="d-flex align-items-center">
            <i class="fas fa-check-circle me-3 fs-4"></i>
            <div>
                <h6 class="alert-heading mb-1">Succès !</h6>
                <p class="mb-0">{{ session('succes_message') }}</p>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
@endif

{{-- Affichage des erreurs formatées --}}
@if($errors->any())
    @foreach($errors->all() as $error)
        @php
            $errorFormat = formatErrorMessage($error);
        @endphp
        
        <div class="alert alert-{{ $errorFormat['type'] }} alert-dismissible fade show mb-3" role="alert">
            <div class="d-flex align-items-start">
                <i class="fas {{ $errorFormat['icon'] }} me-3 mt-1 fs-5"></i>
                <div class="flex-grow-1">
                    <h6 class="alert-heading mb-2">{{ $errorFormat['title'] }}</h6>
                    <p class="mb-0">{{ $errorFormat['message'] }}</p>
                    
                    {{-- Affichage de détails supplémentaires si c'est un conflit --}}
                    @if(str_contains($error, 'Conflit avec la réservation'))
                        <small class="text-muted d-block mt-1">
                            <i class="fas fa-info-circle me-1"></i>
                            Veuillez choisir un autre créneau horaire.
                        </small>
                    @endif
                    
                    {{-- Affichage de détails pour les erreurs de capacité --}}
                    @if(str_contains($error, 'participants'))
                        <small class="text-muted d-block mt-1">
                            <i class="fas fa-info-circle me-1"></i>
                            Réduisez le nombre de participants ou choisissez une salle plus grande.
                        </small>
                    @endif
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    @endforeach
@endif

{{-- Messages d'aide contextuelle --}}
@if($errors->any())
    <div class="alert alert-light border-start border-primary border-4 mb-4">
        <div class="d-flex align-items-start">
            <i class="fas fa-lightbulb text-primary me-3 mt-1"></i>
            <div>
                <h6 class="text-primary mb-2">Conseils pour la validation :</h6>
                <ul class="mb-0 small text-muted">
                    <li>Vérifiez que la réservation n'est pas déjà commencée ou terminée</li>
                    <li>Assurez-vous qu'il n'y a pas de conflit avec d'autres réservations</li>
                    <li>Consultez le planning pour voir les créneaux disponibles</li>
                    <li>Vérifiez vos permissions d'accès</li>
                </ul>
            </div>
        </div>
    </div>
@endif

{{-- Styles CSS personnalisés pour améliorer l'apparence --}}
<style>
.alert {
    border: none;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.alert-success {
    background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
    color: #155724;
    border-left: 4px solid #28a745;
}

.alert-danger {
    background: linear-gradient(135deg, #f8d7da 0%, #f1b8bb 100%);
    color: #721c24;
    border-left: 4px solid #dc3545;
}

.alert-warning {
    background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
    color: #856404;
    border-left: 4px solid #ffc107;
}

.alert-heading {
    font-weight: 600;
    font-size: 1.1rem;
}

.alert .fas {
    opacity: 0.8;
}

.border-start {
    border-left-width: 4px !important;
}
</style>
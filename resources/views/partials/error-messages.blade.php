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
            'La capacité de la salle est dépassée' => [
            'title' => 'Capacité insuffisante',
            'message' => 'Nombre de participants supérieur à la capacité de la salle.',
            'icon' => 'fa-users-slash',
            'type' => 'danger'
        ],
        
        // Salle inappropriée
        'Vous réservez une grande salle pour peu de personnes' => [
            'title' => 'Salle inadaptée',
            'message' => 'Une salle plus petite serait plus appropriée.',
            'icon' => 'fa-door-open',
            'type' => 'warning'
    ],
        // Erreurs de dates
        'Impossible de valider une réservation déjà terminée' => [
            'title' => 'Date dépassée',
            'message' => 'La date de fin est antérieure à aujourd\'hui.',
            'icon' => 'fa-calendar-times',
            'type' => 'danger'
        ],
        'Impossible de valider une réunion déjà commencée' => [
            'title' => 'Réunion en cours',
            'message' => 'La réservation a déjà commencé.',
            'icon' => 'fa-running',
            'type' => 'warning'
        ],
        
        // Conflits existants
        'Ce créneau est déjà réservé' => [
            'title' => 'Conflit de réservation',
            'message' => $error, // On conserve le message détaillé
            'icon' => 'fa-calendar-alt',
            'type' => 'danger'
        ],
        
        // Durée
        'Durée maximale dépassée' => [
            'title' => 'Durée invalide',
            'message' => $error, // Message déjà formaté
            'icon' => 'fa-hourglass-end',
            'type' => 'danger'
        ],
        'La réservation doit durer au moins 15 minutes' => [
            'title' => 'Durée trop courte',
            'message' => 'La durée minimale est de 15 minutes.',
            'icon' => 'fa-hourglass-start',
            'type' => 'warning'
        ],
        'Les réservations ne peuvent pas s\'étendre sur plusieurs jours' => [
            'title' => 'Durée sur plusieurs jours',
            'message' => 'La réservation doit commencer et finir le même jour.',
            'icon' => 'fa-calendar-day',
            'type' => 'danger'
        ],
        ];
        
        // Chercher un message correspondant
        foreach ($userFriendlyMessages as $pattern => $format) {
            if (str_contains($error, $pattern)) {
                return $format;
            }
        }
        
        // Message par défaut pour les erreurs non reconnues
        return [
            'title' => 'Erreur de réservation',
            'message' => 'Une erreur s\'est produite lors de la réservation. Veuillez vérifier vos informations.',
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
                            {{ $error }}
                        </small>
                    @endif
                    
                    {{-- Affichage de détails pour les erreurs de capacité --}}
                    @if(str_contains($error, 'participants'))
                        <small class="text-muted d-block mt-1">
                            <i class="fas fa-info-circle me-1"></i>
                            {{ $error }}
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
                <h6 class="text-primary mb-2">Conseils pour votre réservation :</h6>
                <ul class="mb-0 small text-muted">
                    <li>Vérifiez que vos horaires sont entre 8h00 et 20h00</li>
                    <li>Évitez les dimanches et jours fériés</li>
                    <li>Consultez le planning pour voir les créneaux disponibles</li>
                    <li>Vérifiez la capacité de la salle avant de réserver</li>
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
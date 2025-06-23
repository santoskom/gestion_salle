// ======= VALIDATION JAVASCRIPT POUR RÉSERVATIONS =======

class ReservationValidator {
    constructor() {
        this.initializeElements();
        this.bindEvents();
        this.initializeValidation();
    }

    // Initialisation des éléments DOM
    initializeElements() {
        this.form = document.querySelector('.settings-form');
        this.salleSelect = document.getElementById('salle_id');
        this.dateDebut = document.getElementById('date_debut');
        this.dateFin = document.getElementById('date_fin');
        this.objetReunion = document.getElementById('objet_reunion');
        this.nombreParticipants = document.getElementById('nombreParticipants');
        this.description = document.getElementById('description');
        this.capaciteInfo = document.getElementById('capacite_info');
        this.capaciteMax = document.getElementById('capacite_max');
        this.salleDetails = document.getElementById('salle_details');
        
        // Conteneur pour les messages d'erreur
        this.createErrorContainer();
    }

    // Créer le conteneur pour les messages d'erreur
    createErrorContainer() {
        if (!document.getElementById('validation-messages')) {
            const container = document.createElement('div');
            container.id = 'validation-messages';
            container.className = 'validation-messages mb-3';
            this.form.insertBefore(container, this.form.firstChild);
        }
        this.errorContainer = document.getElementById('validation-messages');
    }

    // Liaison des événements
    bindEvents() {
        // Validation en temps réel
        this.salleSelect.addEventListener('change', () => this.validateSalle());
        this.dateDebut.addEventListener('change', () => this.validateDates());
        this.dateFin.addEventListener('change', () => this.validateDates());
        this.objetReunion.addEventListener('input', () => this.validateObjetReunion());
        this.nombreParticipants.addEventListener('input', () => this.validateCapacite());
        
        // Validation avant soumission
        this.form.addEventListener('submit', (e) => this.validateForm(e));
        
        // Mise à jour automatique des informations
        this.salleSelect.addEventListener('change', () => this.updateSalleInfo());
        this.dateDebut.addEventListener('change', () => this.checkAvailability());
        this.dateFin.addEventListener('change', () => this.checkAvailability());
    }

    // Initialisation des validations
    initializeValidation() {
        this.setDateConstraints();
        if (this.salleSelect.value) {
            this.updateSalleInfo();
        }
    }

    // ======= VALIDATIONS SPÉCIFIQUES =======

    // Validation de la salle
    validateSalle() {
        const salleId = this.salleSelect.value;
        const errors = [];

        if (!salleId) {
            errors.push({
                type: 'warning',
                title: 'Salle requise',
                message: 'Veuillez sélectionner une salle pour continuer.'
            });
        }

        this.updateFieldValidation('salle_id', errors);
        return errors.length === 0;
    }

    // Validation des dates
    validateDates() {
        const errors = [];
        const dateDebut = new Date(this.dateDebut.value);
        const dateFin = new Date(this.dateFin.value);
        const now = new Date();

        // Date de début dans le passé
        if (dateDebut < now) {
            errors.push({
                type: 'danger',
                title: 'Date de début invalide',
                message: 'La date de début ne peut pas être dans le passé.'
            });
        }

        // Date de fin antérieure à la date de début
        if (dateFin <= dateDebut) {
            errors.push({
                type: 'danger',
                title: 'Dates incohérentes',
                message: 'La date de fin doit être postérieure à la date de début.'
            });
        }

        // Validation des heures d'ouverture (6h-20h)
        if (this.dateDebut.value && this.dateFin.value) {
            const heureDebut = dateDebut.getHours();
            const heureFin = dateFin.getHours();

            if (heureDebut < 6 || heureDebut >= 20) {
                errors.push({
                    type: 'warning',
                    title: 'Horaires d\'ouverture',
                    message: 'Les réservations sont autorisées entre 8h et 20h. Heure de début non conforme.'
                });
            }

            if (heureFin < 8 || heureFin > 20) {
                errors.push({
                    type: 'warning',
                    title: 'Horaires d\'ouverture',
                    message: 'Les réservations sont autorisées entre 8h et 20h. Heure de fin non conforme.'
                });
            }

            // Validation des jours exclus (dimanche)
            if (dateDebut.getDay() === 0 || dateFin.getDay() === 0) {
                errors.push({
                    type: 'danger',
                    title: 'Jour non autorisé',
                    message: 'Les réservations ne sont pas autorisées le dimanche.'
                });
            }

            // Calcul et validation de la durée
            this.validateDuration(dateDebut, dateFin, errors);
        }
 const hasBlockingErrors = errors.some(err => err.type === 'danger');
        this.updateFieldValidation('dates', errors);
        // return errors.length === 0;
         return !hasBlockingErrors;
    }

    // Validation de la durée
   validateDuration(dateDebut, dateFin, errors) {
    // Calcul de la durée totale en heures
    const dureeHeuresTotale = Math.abs(dateFin - dateDebut) / (1000 * 60 * 60);

    // Calcul de la durée en jours ouvrables (sans dimanche)
    let joursSansDimanche = 0;
    const current = new Date(dateDebut);

    while (current <= dateFin) {
        const jour = current.getDay(); // 0 = dimanche
        if (jour !== 0) {
            joursSansDimanche++;
        }
        current.setDate(current.getDate() + 1);
    }

    // Recalcule des heures sans dimanches (approximatif)
    const dureeJours = joursSansDimanche;
    const dureeHeures = dureeJours * 24;

    // Durée minimale (15 minutes)
    if (dureeHeuresTotale < 0.25) {
        errors.push({
            type: 'warning',
            title: 'Durée trop courte',
            message: 'La réservation doit durer au moins 15 minutes.'
        });
    }

    // Réservation multi-jours (info uniquement)
    if (!this.isSameDay(dateDebut, dateFin)) {
        errors.push({
            type: 'info',
            title: 'Réservation multi-jours',
            message: `Réservation de ${dureeJours.toFixed(2)} jour(s) (hors dimanches) autorisée.`
        });
    }

    // Durées spéciales (exemple 3 à 10 jours)
    if (dureeJours >= 3 && dureeJours <= 10) {
        errors.push({
            type: 'info',
            title: 'Longue réservation',
            message: `Réservation de ${dureeJours.toFixed(2)} jour(s) (hors dimanches). Vérifiez la disponibilité.`
        });
    }

    // Plus de 10 jours (hors dimanches)
    if (dureeJours > 10) {
        errors.push({
            type: 'warning',
            title: 'Durée exceptionnelle',
            message: `Réservation de ${dureeJours.toFixed(2)} jours (hors dimanches). Validation manuelle conseillée.`
        });
    }

    // Affichage de la durée calculée
    this.displayDuration(dureeHeuresTotale, dureeJours);
}

    // Validation de l'objet de réunion
    validateObjetReunion() {
        const errors = [];
        const objet = this.objetReunion.value.trim().toLowerCase();

        if (objet.length < 3) {
            errors.push({
                type: 'warning',
                title: 'Objet trop court',
                message: 'L\'objet de la réunion doit contenir au moins 3 caractères.'
            });
        }

        // Détection de la priorité
        const priorite = this.getObjectPriority(objet);
        if (priorite >= 5) {
            errors.push({
                type: 'success',
                title: 'Réunion haute priorité',
                message: 'Réunion de très haute priorité détectée - Traitement prioritaire.'
            });
        }

        this.updateFieldValidation('objet_reunion', errors);
        return errors.length === 0;
    }

    // Validation de la capacité
    validateCapacite() {
        const errors = [];
        const nombreParticipants = parseInt(this.nombreParticipants.value);
        const selectedOption = this.salleSelect.options[this.salleSelect.selectedIndex];
        const capaciteSalle = selectedOption ? parseInt(selectedOption.dataset.capacite) : 0;

        if (nombreParticipants && capaciteSalle) {
            if (nombreParticipants > capaciteSalle) {
                errors.push({
                    type: 'danger',
                    title: 'Capacité dépassée',
                    message: `Nombre de participants (${nombreParticipants}) supérieur à la capacité de la salle (${capaciteSalle}).`
                });
            } else if (nombreParticipants < 5 && capaciteSalle > 11) {
                errors.push({
                    type: 'info',
                    title: 'Optimisation suggérée',
                    message: `Vous réservez une grande salle (${capaciteSalle} places) pour peu de personnes (${nombreParticipants}). Considérez une salle plus petite.`
                });
            }
        }

        this.updateFieldValidation('nombreParticipants', errors);
        return errors.length === 0;
    }

    // ======= FONCTIONS UTILITAIRES =======

    // Définition des contraintes de date
    setDateConstraints() {
        const now = new Date();
        const minDate = now.toISOString().slice(0, 16);
        this.dateDebut.min = minDate;
        this.dateFin.min = minDate;
    }

    // Mise à jour des informations de la salle
    updateSalleInfo() {
        const selectedOption = this.salleSelect.options[this.salleSelect.selectedIndex];
        if (selectedOption && selectedOption.value) {
            const capacite = selectedOption.dataset.capacite;
            this.capaciteMax.textContent = capacite;
            this.salleDetails.innerHTML = `
                <small class="text-success">
                    <i class="fas fa-info-circle"></i> 
                    Salle sélectionnée: ${selectedOption.text}
                </small>
            `;
        } else {
            this.salleDetails.innerHTML = '';
            this.capaciteMax.textContent = '0';
        }
    }

    // Vérification de disponibilité (simulation)
    async checkAvailability() {
        if (this.dateDebut.value && this.dateFin.value && this.salleSelect.value) {
            // Simulation d'une vérification de conflit
            this.showAvailabilityStatus('checking');
            
            // Ici vous pourriez faire un appel AJAX pour vérifier les conflits réels
            setTimeout(() => {
                this.showAvailabilityStatus('available');
            }, 1000);
        }
    }

    // Affichage du statut de disponibilité
    showAvailabilityStatus(status) {
        let message = '';
        let className = '';
        
        switch (status) {
            case 'checking':
                message = '<i class="fas fa-spinner fa-spin"></i> Vérification de la disponibilité...';
                className = 'text-info';
                break;
            case 'available':
                message = '<i class="fas fa-check-circle"></i> Salle disponible pour cette période';
                className = 'text-success';
                break;
            case 'conflict':
                message = '<i class="fas fa-exclamation-triangle"></i> Conflit détecté avec une autre réservation';
                className = 'text-danger';
                break;
        }
        
        this.salleDetails.innerHTML = `<small class="${className}">${message}</small>`;
    }

    // Calcul de priorité d'objet
    getObjectPriority(objet) {
        const priorities = {
            'conseil d\'administration': 5,
            'assemblée générale': 5,
            'comité de direction': 5,
            'audit externe': 5,
            'réunion stratégique': 4,
            'formation': 3,
            'réunion équipe': 3,
            'briefing': 2,
            'réunion informelle': 1
        };

        // Recherche exacte
        if (priorities[objet]) {
            return priorities[objet];
        }

        // Recherche partielle
        for (const [key, priority] of Object.entries(priorities)) {
            if (objet.includes(key) || key.includes(objet)) {
                return priority;
            }
        }

        return 3; // priorité moyenne par défaut
    }

    // Vérification si même jour
    isSameDay(date1, date2) {
        return date1.toDateString() === date2.toDateString();
    }

    // Affichage de la durée calculée
    displayDuration(dureeHeures, dureeJours) {
        let durationText = '';
        
        if (dureeJours >= 1) {
            const jours = Math.floor(dureeJours);
            const heuresRestantes = Math.round((dureeJours - jours) * 24);
            durationText = `${jours} jour(s)`;
            if (heuresRestantes > 0) {
                durationText += ` et ${heuresRestantes} heure(s)`;
            }
        } else {
            const heures = Math.floor(dureeHeures);
            const minutes = Math.round((dureeHeures - heures) * 60);
            if (heures > 0) {
                durationText = `${heures} heure(s)`;
                if (minutes > 0) {
                    durationText += ` et ${minutes} minute(s)`;
                }
            } else {
                durationText = `${minutes} minute(s)`;
            }
        }

        // Affichage sous le champ date de fin
        let durationInfo = document.getElementById('duration-info');
        if (!durationInfo) {
            durationInfo = document.createElement('div');
            durationInfo.id = 'duration-info';
            durationInfo.className = 'text-muted mt-1';
            this.dateFin.parentNode.appendChild(durationInfo);
        }
        
        durationInfo.innerHTML = `<small><i class="fas fa-clock"></i> Durée: ${durationText}</small>`;
    }

    // ======= GESTION DES MESSAGES =======

    // Mise à jour de la validation d'un champ
    updateFieldValidation(fieldName, errors) {
        this.clearFieldErrors(fieldName);
        
        if (errors.length > 0) {
            this.displayFieldErrors(fieldName, errors);
        }
    }

    // Suppression des erreurs d'un champ
    clearFieldErrors(fieldName) {
        const existingErrors = document.querySelectorAll(`[data-field="${fieldName}"]`);
        existingErrors.forEach(error => error.remove());
    }

    // Affichage des erreurs d'un champ
    displayFieldErrors(fieldName, errors) {
        errors.forEach(error => {
            const errorElement = this.createErrorElement(error, fieldName);
            this.errorContainer.appendChild(errorElement);
        });
    }

    // Création d'un élément d'erreur
    createErrorElement(error, fieldName) {
        const div = document.createElement('div');
        div.className = `alert alert-${error.type} alert-dismissible fade show`;
        div.setAttribute('data-field', fieldName);
        
        div.innerHTML = `
            <strong>${error.title}:</strong> ${error.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        return div;
    }

    // Validation complète du formulaire
    validateForm(event) {
        const isValid = this.validateSalle() && 
                       this.validateDates() && 
                       this.validateObjetReunion() && 
                       this.validateCapacite();

        if (!isValid) {
            event.preventDefault();
            this.scrollToFirstError();
            
            // Message général
            this.displayMessage({
                type: 'danger',
                title: 'Erreurs de validation',
                message: 'Veuillez corriger les erreurs ci-dessus avant de soumettre le formulaire.'
            });
        }
    }

    // Scroll vers la première erreur
    scrollToFirstError() {
        const firstError = document.querySelector('.alert-danger');
        if (firstError) {
            firstError.scrollIntoView({ behavior: 'smooth' });
        }
    }

    // Affichage d'un message général
    displayMessage(message) {
        const messageElement = this.createErrorElement(message, 'general');
        this.errorContainer.appendChild(messageElement);
    }
}

// ======= INITIALISATION =======

// Initialisation quand le DOM est prêt
document.addEventListener('DOMContentLoaded', function() {
    new ReservationValidator();
    
    // Ajout de styles CSS pour les messages
    if (!document.getElementById('validation-styles')) {
        const style = document.createElement('style');
        style.id = 'validation-styles';
        style.textContent = `
            .validation-messages {
                max-height: 400px;
                overflow-y: auto;
            }
            
            .validation-messages .alert {
                margin-bottom: 0.5rem;
                padding: 0.5rem 0.75rem;
                font-size: 0.875rem;
            }
            
            .validation-messages .alert:last-child {
                margin-bottom: 0;
            }
            
            #duration-info {
                font-weight: 500;
            }
            
            .form-control.is-valid {
                border-color: #198754;
            }
            
            .form-control.is-invalid {
                border-color: #dc3545;
            }
        `;
        document.head.appendChild(style);
    }
});

// ======= FONCTIONS GLOBALES UTILITAIRES =======

// Fonction pour nettoyer tous les messages
function clearAllValidationMessages() {
    const container = document.getElementById('validation-messages');
    if (container) {
        container.innerHTML = '';
    }
}

// Fonction pour afficher un message custom
function showValidationMessage(type, title, message) {
    const validator = window.reservationValidator;
    if (validator) {
        validator.displayMessage({ type, title, message });
    }
}
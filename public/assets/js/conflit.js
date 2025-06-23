class ReservationConflictManager {
    constructor() {
        this.reservations = [];
        this.currentSalleId = null;
        this.debounceTimer = null;
        this.csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
    }

    /**
     * Initialiser le gestionnaire de conflits
     */
    init() {
        this.bindEvents();
        this.loadInitialData();
    }

    /**
     * Lier les événements aux champs du formulaire
     */
    bindEvents() {
        const salleSelect = document.getElementById('salle_id');
        const dateDebutInput = document.getElementById('date_debut');
        const dateFinInput = document.getElementById('date_fin');

        if (salleSelect) {
            salleSelect.addEventListener('change', () => {
                this.currentSalleId = salleSelect.value;
                this.loadReservations();
            });
        }

        if (dateDebutInput && dateFinInput) {
            [dateDebutInput, dateFinInput].forEach(input => {
                input.addEventListener('change', () => this.debounceCheckConflicts());
                input.addEventListener('input', () => this.debounceCheckConflicts());
            });
        }
    }

    /**
     * Charger les données initiales si une salle est déjà sélectionnée
     */
    loadInitialData() {
        const salleSelect = document.getElementById('salle_id');
        if (salleSelect && salleSelect.value) {
            this.currentSalleId = salleSelect.value;
            this.loadReservations();
        }
    }

    /**
     * Débouncer la vérification des conflits
     */
    debounceCheckConflicts() {
        clearTimeout(this.debounceTimer);
        this.debounceTimer = setTimeout(() => {
            this.checkConflicts();
        }, 500);
    }

    /**
     * Charger les réservations pour une salle
     */
    async loadReservations() {
        if (!this.currentSalleId) return;

        try {
            const dateDebut = document.getElementById('date_debut')?.value;
            const dateFin = document.getElementById('date_fin')?.value;

            if (!dateDebut || !dateFin) return;

            const params = new URLSearchParams({
                salle_id: this.currentSalleId,
                date_debut: dateDebut,
                date_fin: dateFin
            });
alert('ok');
            const response = await fetch(`/api/reservations/salle?${params}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': this.csrfToken,
                    'X-Requested-With': 'XMLHttpRequest'
                }
            });

            if (!response.ok) {
                throw new Error('Erreur lors du chargement des réservations');
            }

            const data = await response.json();
            this.reservations = data.reservations || [];
            this.checkConflicts();

        } catch (error) {
            console.error('Erreur:', error);
            this.showError('Erreur lors du chargement des réservations existantes');
        }
    }

    /**
     * Vérifier les conflits côté client
     */
    checkConflicts() {
        const dateDebut = document.getElementById('date_debut')?.value;
        const dateFin = document.getElementById('date_fin')?.value;
        const reservationId = document.getElementById('reservation_id')?.value;

        if (!dateDebut || !dateFin || !this.currentSalleId) {
            this.clearConflictMessages();
            return;
        }

        const startDate = new Date(dateDebut);
        const endDate = new Date(dateFin);

        // Vérification côté client avec les données en cache
        const conflictingReservation = this.findConflictingReservation(
            startDate, 
            endDate, 
            reservationId
        );

        if (conflictingReservation) {
            this.showConflictWarning(conflictingReservation);
            this.disableSubmitButton();
        } else {
            this.clearConflictMessages();
            this.enableSubmitButton();
            // Vérification côté serveur pour être sûr
            this.serverCheckConflicts();
        }
    }

    /**
     * Trouver une réservation en conflit dans les données locales
     */
    findConflictingReservation(startDate, endDate, excludeId = null) {
        return this.reservations.find(reservation => {
            if (excludeId && reservation.id == excludeId) {
                return false;
            }

            const reservationStart = new Date(reservation.date_debut);
            const reservationEnd = new Date(reservation.date_fin);

            // Vérifier le chevauchement
            return startDate < reservationEnd && endDate > reservationStart;
        });
    }

    /**
     * Vérification côté serveur (double vérification)
     */
    async serverCheckConflicts() {
        const dateDebut = document.getElementById('date_debut')?.value;
        const dateFin = document.getElementById('date_fin')?.value;
        const reservationId = document.getElementById('reservation_id')?.value;

        try {
            const response = await fetch('/api/reservations/check-conflicts', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': this.csrfToken,
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify({
                    salle_id: this.currentSalleId,
                    date_debut: dateDebut,
                    date_fin: dateFin,
                    reservation_id: reservationId
                })
            });

            if (!response.ok) {
                throw new Error('Erreur lors de la vérification des conflits');
            }

            const data = await response.json();
            
            if (data.has_conflict) {
                this.showConflictError(data.message);
                this.disableSubmitButton();
            }

        } catch (error) {
            console.error('Erreur lors de la vérification serveur:', error);
        }
    }

    /**
     * Afficher un avertissement de conflit
     */
    showConflictWarning(conflictingReservation) {
        const startDate = new Date(conflictingReservation.date_debut).toLocaleString('fr-FR');
        const endDate = new Date(conflictingReservation.date_fin).toLocaleString('fr-FR');
        
        const message = `⚠️ Conflit détecté avec la réservation "${conflictingReservation.objet_reunion}" du ${startDate} au ${endDate}`;
        
        this.displayMessage(message, 'warning');
    }

    /**
     * Afficher une erreur de conflit
     */
    showConflictError(message) {
        this.displayMessage(`❌ ${message}`, 'error');
    }

    /**
     * Afficher une erreur générale
     */
    showError(message) {
        this.displayMessage(`❌ ${message}`, 'error');
    }

    /**
     * Afficher un message dans l'interface
     */
    displayMessage(message, type) {
        // Supprimer les anciens messages
        this.clearConflictMessages();

        const messageDiv = document.createElement('div');
        messageDiv.className = `conflict-message alert ${type === 'error' ? 'alert-danger' : 'alert-warning'}`;
        messageDiv.innerHTML = message;

        // Insérer le message après le champ date_fin
        const dateFinGroup = document.getElementById('date_fin')?.closest('.form-group') || 
                           document.getElementById('date_fin')?.parentElement;
        
        if (dateFinGroup) {
            dateFinGroup.insertAdjacentElement('afterend', messageDiv);
        }
    }

    /**
     * Supprimer tous les messages de conflit
     */
    clearConflictMessages() {
        document.querySelectorAll('.conflict-message').forEach(el => el.remove());
    }

    /**
     * Désactiver le bouton de soumission
     */
    disableSubmitButton() {
        const submitBtn = document.querySelector('button[type="submit"], input[type="submit"]');
        if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.classList.add('btn-disabled');
        }
    }

    /**
     * Activer le bouton de soumission
     */
    enableSubmitButton() {
        const submitBtn = document.querySelector('button[type="submit"], input[type="submit"]');
        if (submitBtn) {
            submitBtn.disabled = false;
            submitBtn.classList.remove('btn-disabled');
        }
    }
}

// Initialiser le gestionnaire quand le DOM est prêt
document.addEventListener('DOMContentLoaded', function() {
    const conflictManager = new ReservationConflictManager();
    conflictManager.init();
});

// CSS à ajouter dans votre fichier de styles
const styles = `
.conflict-message {
    margin: 10px 0;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid;
}

.alert-warning {
    background-color: #fff3cd;
    border-color: #ffeeba;
    color: #856404;
}

.alert-danger {
    background-color: #f8d7da;
    border-color: #f5c6cb;
    color: #721c24;
}

.btn-disabled {
    opacity: 0.6;
    cursor: not-allowed;
}
`;

// Injecter les styles
const styleSheet = document.createElement('style');
styleSheet.textContent = styles;
document.head.appendChild(styleSheet);
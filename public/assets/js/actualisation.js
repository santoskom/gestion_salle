
document.addEventListener('DOMContentLoaded', function() {
    // Mise à jour de la capacité lorsque la salle change
    const salleSelect = document.getElementById('salle_id');
    const capaciteMax = document.getElementById('capacite_max');
    const nombreParticipants = document.getElementById('nombreParticipants');
    
    if (salleSelect) {
        salleSelect.addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const capacite = selectedOption.getAttribute('data-capacite');
            capaciteMax.textContent = capacite;
            
            // Validation immédiate de la capacité
            if (nombreParticipants.value && parseInt(nombreParticipants.value) > parseInt(capacite)) {
                nombreParticipants.classList.add('is-invalid');
            } else {
                nombreParticipants.classList.remove('is-invalid');
            }
        });
    }
    
    // Validation de la capacité en temps réel
    if (nombreParticipants) {
        nombreParticipants.addEventListener('input', function() {
            const capacite = parseInt(capaciteMax.textContent);
            const participants = parseInt(this.value) || 0;
            
            if (participants > capacite) {
                this.classList.add('is-invalid');
            } else {
                this.classList.remove('is-invalid');
            }
        });
    }
    
    // Validation des dates
    const dateDebut = document.getElementById('date_debut');
    const dateFin = document.getElementById('date_fin');
    
    if (dateDebut && dateFin) {
        dateDebut.addEventListener('change', function() {
            if (dateFin.value && new Date(dateFin.value) <= new Date(this.value)) {
                dateFin.classList.add('is-invalid');
            } else {
                dateFin.classList.remove('is-invalid');
            }
        });
        
        dateFin.addEventListener('change', function() {
            if (dateDebut.value && new Date(this.value) <= new Date(dateDebut.value)) {
                this.classList.add('is-invalid');
            } else {
                this.classList.remove('is-invalid');
            }
        });
    }
});


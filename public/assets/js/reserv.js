document.addEventListener('DOMContentLoaded', function() {
    const salleSelect = document.getElementById('salle_id');
    const nombreParticipants = document.getElementById('nombreParticipants');
    const capaciteWarning = document.getElementById('capacite_warning');
    
    function checkCapacite() {
        if (salleSelect.selectedIndex > 0 && nombreParticipants.value) {
            const selectedOption = salleSelect.options[salleSelect.selectedIndex];
            const capacite = parseInt(selectedOption.dataset.capacite);
            const participants = parseInt(nombreParticipants.value);
            
            if (participants > capacite) {
                capaciteWarning.classList.remove('d-none');
            } else {
                capaciteWarning.classList.add('d-none');
            }
        }
    }
    
    salleSelect.addEventListener('change', checkCapacite);
    nombreParticipants.addEventListener('input', checkCapacite);
    
    // Vérifier initialement
    checkCapacite();
});
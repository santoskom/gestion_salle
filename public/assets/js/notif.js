
document.addEventListener('DOMContentLoaded', function() {
    // Fonction pour mettre à jour le compteur de notifications
    function updateNotificationCount() {
        fetch('/notifications/count', {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest',
                'Accept': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            },
            credentials: 'same-origin'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur réseau');
            }
            return response.json();
        })
        .then(data => {
            const countElement = document.getElementById('notification-count');
            if (countElement) {
                if (data.count === 0) {
                    countElement.textContent = '';
                    countElement.classList.add('d-none');
                } else {
                    countElement.textContent = data.count;
                    countElement.classList.remove('d-none');
                }
            }
        })
        .catch(error => console.error('Erreur lors de la récupération des notifications:', error));
    }

    // Fonction pour marquer une notification comme lue
    function markAsRead(notificationId) {
        // Récupérer le jeton CSRF
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        
        fetch(`/notifications/${notificationId}/read`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'X-CSRF-TOKEN': csrfToken
            },
            credentials: 'same-origin'
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Erreur réseau');
            }
            return response.json();
        })
        .then(data => {
            // Mettre à jour le compteur
            updateNotificationCount();
            
            // Mettre à jour l'apparence de la notification (optionnellement)
            const notificationElement = document.querySelector(`[data-notification-id="${notificationId}"]`);
            if (notificationElement) {
                notificationElement.classList.remove('bg-light', 'unread');
            }
        })
        .catch(error => console.error('Erreur lors du marquage comme lu:', error));
    }

    // Event listener pour les boutons de notification
    document.querySelectorAll('.mark-as-read').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const notificationId = this.getAttribute('data-id');
            markAsRead(notificationId);
        });
    });

    // Event listener pour les liens de notification
    document.querySelectorAll('.notification-link').forEach(link => {
        link.addEventListener('click', function(e) {
            const notificationId = this.getAttribute('data-id');
            if (notificationId) {
                markAsRead(notificationId);
            }
        });
    });

    // Mettre à jour le compteur au chargement et toutes les 30 secondes
    updateNotificationCount();
    setInterval(updateNotificationCount, 500);
});


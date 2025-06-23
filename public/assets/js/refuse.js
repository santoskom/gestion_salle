document.addEventListener('DOMContentLoaded', function() {
    // Récupérer les données du contrôleur
    const refusedChartData = @json($refusedChartData);
    
    
    // Créer le graphe des réservations refusées
    const refusedCtx = document.getElementById('refusedReservationsChart').getContext('2d');
    new Chart(refusedCtx, {
        type: 'bar',
        data: refusedChartData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                },
                title: {
                    display: true,
                    text: 'Nombre de réservations refusées par entreprise'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.dataset.label + ': ' + context.raw + ' réservations';
                        }
                    }
                }
            }
        }
    });
});
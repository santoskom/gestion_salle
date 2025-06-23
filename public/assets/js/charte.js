document.addEventListener('DOMContentLoaded', function () {
    const ctx = document.getElementById('salleReservationsWeeklyChart')?.getContext('2d');
    if (!ctx || typeof salleReservationDatasets === 'undefined') return;

    const currentDate = new Date();
    const currentDay = currentDate.getDay();
    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(currentDate.getDate() - currentDay);

    const labels = [...Array(7)].map((_, i) => {
        const day = new Date(startOfWeek);
        day.setDate(startOfWeek.getDate() + i);
        return `Jour ${i + 1} - ${day.toLocaleDateString()}`;
    });

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: salleReservationDatasets
        },
        options: {
            responsive: true,
            interaction: {
                mode: 'index',
                intersect: false,
            },
            plugins: {
                title: {
                    display: true,
                    text: 'Évolution quotidienne des réservations'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Nombre de réservations'
                    }
                }
            }
        }
    });
});

@extends('layoutss.template')

@section('content')
    @if($refusedChartData && count($refusedChartData['labels']) > 0)
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">Réservations refusées par entreprise</h5>
            </div>
            <div class="card-body">
                <div class="chart-container" style="position: relative; height:300px;">
                    <canvas id="refusedReservationsChart"></canvas>
                </div>
            </div>
        </div>
    @else
        <div class="card">
            <div class="card-header">
                <h5 class="card-title">Réservations refusées par entreprise</h5>
            </div>
            <div class="card-body">
                <p class="text-muted">Aucune donnée de réservations refusées à afficher.</p>
            </div>
        </div>
    @endif
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Récupérer les données du contrôleur
            const refusedChartData = @json($refusedChartData);
            
            console.log('Données reçues:', refusedChartData); // Pour debug
            
            // Vérifier si les données existent et ne sont pas vides
            if (refusedChartData && refusedChartData.labels && refusedChartData.labels.length > 0) {
                // Créer le graphe des réservations refusées
                const refusedCtx = document.getElementById('refusedReservationsChart');
                
                if (refusedCtx) {
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
                } else {
                    console.error('Element canvas non trouvé');
                }
            } else {
                console.log('Aucune donnée à afficher pour le graphique');
            }
        });
    </script>
@endpush
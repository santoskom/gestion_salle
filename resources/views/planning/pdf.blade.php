<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planning de réservation des salles</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
            line-height: 1.5;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 18px;
            margin-bottom: 5px;
        }
        .header p {
            font-size: 14px;
            margin-top: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            font-size: 11px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .day-header {
            background-color: #4a86e8;
            color: white;
            padding: 8px;
            margin-top: 15px;
            margin-bottom: 5px;
            font-size: 14px;
        }
        .footer {
            text-align: center;
            font-size: 10px;
            margin-top: 20px;
        }
        .no-data {
            text-align: center;
            font-style: italic;
            padding: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>RESERVATION DE LA SALLE DE REUNION</h1>
        <p>Période du {{ $date_debut }} au {{ $date_fin }}</p>
        <p>Salle: {{ $salle }} | Département: {{ $departement }}</p>
    </div>
    
    @foreach($planningData as $date => $planning)
        <div class="day-header">
            {{ $planning['jour'] }} {{ $planning['date'] }}
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Demandeur</th>
                    <th>Horaire</th>
                    <th>Objet</th>
                    <th>Nombre Personnes</th>
                    <th>Service</th>
                    <th>Commentaire</th>
                </tr>
            </thead>
            <tbody>
                @forelse($planning['reservations'] as $reservation)
                    <tr>
                        <td>{{ $reservation->demandeur }}</td>
                        <td>{{ substr($reservation->heure_debut, 0, 5) }} - {{ substr($reservation->heure_fin, 0, 5) }}</td>
                        <td>{{ $reservation->objet }}</td>
                        <td>{{ $reservation->nombre_personnes ?? '-' }}</td>
                        <td>{{ $reservation->service->nom ?? '-' }}</td>
                        <td>{{ $reservation->commentaire ?? '-' }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="6" class="no-data">Aucune réservation pour cette journée</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    @endforeach
    
    <div class="footer">
        <p>Document généré le {{ date('d/m/Y H:i') }}</p>
    </div>
</body>
</html>
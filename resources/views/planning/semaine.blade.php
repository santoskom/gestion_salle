@extends('layoutss.template')

@section('content')
<div class="container">
    <h3 class="mb-4">Planning Hebdomadaire des Salles</h3>

    <form method="GET" action="{{ route('planning.semaine') }}" class="mb-4">
        <div class="form-inline">
            <label class="mr-2">Choisir la date (semaine) :</label>
            <input type="date" name="date" class="form-control mr-2" value="{{ request('date') ?? \Carbon\Carbon::now()->toDateString() }}">
            
            <label class="mr-2">Salle :</label>
            <select name="salle_id" class="form-control mr-2">
                <option value="">Toutes les salles</option>
                @foreach ($salles as $salle)
                    <option value="{{ $salle->id }}" {{ $salleSelectionnee == $salle->id ? 'selected' : '' }}>
                        {{ $salle->nom }}
                    </option>
                @endforeach
            </select>

            <button class="btn btn-primary">Afficher</button>
        </div>
    </form>

    @foreach ($salles as $salle)
        <h5 class="mt-5">Salle : {{ $salle->nom }}</h5>
        <table class="table table-bordered table-sm text-center">
            <thead class="thead-light">
                <tr>
                    <th>Jour</th>
                    <th>Date</th>
                    <th>Heure</th>
                    <th>Objet</th>
                    <th>Responsable</th>
                    <th>Service</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($jours as $jour)
                    @php
                        $reservationsJour = $planningData[$jour->format('Y-m-d')][$salle->id]['reservations'];
                    @endphp
                    @if (count($reservationsJour) > 0)
                        @foreach ($reservationsJour as $reservation)
                            <tr>
                                <td>{{ ucfirst($jour->locale('fr')->translatedFormat('l')) }}</td>
                                <td>{{ $jour->format('d/m/Y') }}</td>
                                <td>{{ $reservation->heure_debut }} - {{ $reservation->heure_fin }}</td>
                                <td>{{ $reservation->objet }}</td>
                                <td>{{ $reservation->demandeur->nom ?? '-' }}</td>
                                <td>{{ $reservation->demandeur->service ?? '-' }}</td>
                            </tr>
                        @endforeach
                    @else
                        <tr>
                            <td>{{ ucfirst($jour->locale('fr')->translatedFormat('l')) }}</td>
                            <td>{{ $jour->format('d/m/Y') }}</td>
                            <td colspan="4">Aucune réservation</td>
                        </tr>
                    @endif
                @endforeach
            </tbody>
        </table>
    @endforeach
</div>
@endsection
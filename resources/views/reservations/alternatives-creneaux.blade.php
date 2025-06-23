@extends('layoutss.template')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4>Créneaux alternatifs disponibles</h4>
                </div>
                <div class="card-body">
                    @if(session('success'))
                        <div class="alert alert-success">
                            {{ session('success') }}
                        </div>
                    @endif

                    @if(session('error'))
                        <div class="alert alert-danger">
                            {{ session('error') }}
                        </div>
                    @endif

                    <div class="alert alert-info">
                        <p><strong>Votre réservation pour la salle "{{ $salle->nom }}" n'a pas pu être acceptée.</strong></p>
                        <p>Voici des créneaux alternatifs disponibles pour cette même salle.</p>
                    </div>

                    <div class="original-reservation mb-4">
                        <h5>Détails de votre demande initiale :</h5>
                        <div class="card">
                            <div class="card-body">
                                <p><strong>Salle :</strong> {{ $salle->nom }}</p>
                                <p><strong>Créneau demandé :</strong> Du {{ $date_debut }} à {{ $heure_debut }} au {{ $date_fin }} à {{ $heure_fin }}</p>
                                <p><strong>Motif du refus :</strong> {{ $motif_refus }}</p>
                            </div>
                        </div>
                    </div>

                    @if(count($creneaux_alternatifs) > 0)
                        <h5>Choisissez un créneau alternatif :</h5>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Date de début</th>
                                        <th>Heure de début</th>
                                        <th>Date de fin</th>
                                        <th>Heure de fin</th>
                                        <th>Durée</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($creneaux_alternatifs as $creneau)
                                        <tr>
                                            <td>{{ $creneau['date_debut'] }}</td>
                                            <td>{{ $creneau['heure_debut'] }}</td>
                                            <td>{{ $creneau['date_fin'] }}</td>
                                            <td>{{ $creneau['heure_fin'] }}</td>
                                            <td>
                                                @php
                                                    $debut = \Carbon\Carbon::parse($creneau['date_debut'] . ' ' . $creneau['heure_debut']);
                                                    $fin = \Carbon\Carbon::parse($creneau['date_fin'] . ' ' . $creneau['heure_fin']);
                                                    $diffHeures = $debut->diffInHours($fin);
                                                    $diffMinutes = $debut->copy()->addHours($diffHeures)->diffInMinutes($fin);
                                                @endphp
                                                {{ $diffHeures }}h{{ $diffMinutes > 0 ? ' ' . $diffMinutes . 'min' : '' }}
                                            </td>  
                                            <td>
                                                <form action="{{ route('reservations.creer-alternative') }}" method="POST">
                                                    @csrf
                                                    <input type="hidden" name="salle_id" value="{{ $salle->id }}">
                                                    <input type="hidden" name="date_debut" value="{{ $creneau['date_debut'] }}">
                                                    <input type="hidden" name="heure_debut" value="{{ $creneau['heure_debut'] }}">
                                                    <input type="hidden" name="date_fin" value="{{ $creneau['date_fin'] }}">
                                                    <input type="hidden" name="heure_fin" value="{{ $creneau['heure_fin'] }}">
                                                    <input type="hidden" name="motif" value="{{ $motif ?? '' }}">
                                                    <input type="hidden" name="reservation_id_refusee" value="{{ $reservation_id_refusee }}">
                                                    <button type="submit" class="btn btn-primary">Choisir ce créneau</button>
                                                </form>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @else
                        <div class="alert alert-warning">
                            <p>Aucun créneau alternatif n'est disponible pour cette salle.</p>
                        </div>
                    @endif

                    <div class="mt-4">
                        <a href="{{ route('reservations.index') }}" class="btn btn-secondary">Retour à mes réservations</a>
                        <a href="{{ route('reservations.create') }}" class="btn btn-outline-primary">Créer une nouvelle réservation</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
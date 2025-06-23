@extends('layoutss.template')
@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4>Alternatives de salles disponibles</h4>
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
                        <p><strong>Votre réservation initiale n'a pas pu être acceptée.</strong></p>
                        <p>Voici des salles alternatives disponibles pour la période demandée ({{ $date_debut }} à {{ $heure_debut }} - {{ $date_fin }} à {{ $heure_fin }}).</p>
                    </div>

                    <div class="original-reservation mb-4">
                        <h5>Détails de votre demande initiale :</h5>
                        <div class="card">
                            <div class="card-body">
                                <p><strong>Salle demandée :</strong> {{ $original_salle->nom }}</p>
                                <p><strong>Capacité :</strong> {{ $original_salle->capacite }} personnes</p>
                                <p><strong>Équipements :</strong> {{ $original_salle->equipements }}</p>
                                <p><strong>Date et heure :</strong> Du {{ $date_debut }} à {{ $heure_debut }} au {{ $date_fin }} à {{ $heure_fin }}</p>
                                <p><strong>Motif du refus :</strong> {{ $motif_refus }}</p>
                            </div>
                        </div>
                    </div>

                    @if(count($salles_alternatives) > 0)
                        <h5>Choisissez une salle alternative :</h5>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Salle</th>
                                        <th>Emplacement</th>
                                        <th>Capacité</th>
                                        <th>Équipements</th>
                                        <th>Différences</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($salles_alternatives as $salle)
                                        <tr>
                                            <td>{{ $salle->nom }}</td>
                                            <td>{{ $salle->emplacement }}</td>
                                            <td>{{ $salle->capacite }} personnes</td>
                                            <td>{{ $salle->equipements }}</td>
                                            <td>
                                                @if($salle->capacite != $original_salle->capacite)
                                                    <span class="badge bg-info">Capacité différente</span>
                                                @endif
                                                @if($salle->equipements != $original_salle->equipements)
                                                    <span class="badge bg-warning">Équipements différents</span>
                                                @endif
                                            </td>
                                            <td>
                                                <form action="{{ route('reservations.creer-alternative') }}" method="POST">
                                                    @csrf
                                                    <input type="hidden" name="salle_id" value="{{ $salle->id }}">
                                                    <input type="hidden" name="date_debut" value="{{ $date_debut }}">
                                                    <input type="hidden" name="heure_debut" value="{{ $heure_debut }}">
                                                    <input type="hidden" name="date_fin" value="{{ $date_fin }}">
                                                    <input type="hidden" name="heure_fin" value="{{ $heure_fin }}">
                                                    <input type="hidden" name="motif" value="{{ $motif ?? '' }}">
                                                    <input type="hidden" name="reservation_id_refusee" value="{{ $reservation_id_refusee }}">
                                                    <button type="submit" class="btn btn-primary">Choisir cette salle</button>
                                                </form>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @else
                        <div class="alert alert-warning">
                            <p>Aucune salle alternative n'est disponible pour cette période.</p>
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
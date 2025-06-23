@extends('layoutss.template')
@push('styles')
    <link rel="stylesheet" href="{{ asset('assets/css/responsive.css') }}">
@endpush
@section('content')
<div class="container">
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Réservation de la salle de réunion</h3>
                </div>
                            
            <div class="week-navigation d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h4>Planning du {{ $navigation['currentWeekStart'] }} au {{ $navigation['currentWeekEnd'] }}</h4>
                </div>
                <div class="btn-group">
                    <a href="{{ route('planning.index', ['week' => $navigation['previousWeek'], 'salle_id' => $salle_id, 'departement_id' => $departement_id]) }}" 
                    class="btn btn-outline-primary">
                        prev
                    </a>
                    <a href="{{ route('planning.index', ['week' => 0, 'salle_id' => $salle_id, 'departement_id' => $departement_id]) }}" 
                    class="btn btn-outline-primary {{ $navigation['currentWeek'] == 0 ? 'active' : '' }}">
                        now
                    </a>
                    <a href="{{ route('planning.index', ['week' => $navigation['nextWeek'], 'salle_id' => $salle_id, 'departement_id' => $departement_id]) }}" 
                    class="btn btn-outline-primary">
                        next 
                    </a>
                </div>
            </div>

                        <div class="card-body">
                    <form action="{{ route('planning.index') }}" method="GET" class="form-row align-items-center  d-flex justify-content-center align-items-center">
                        <div class="col-md-3 mb-2">
                            <label for="salle_id">Salle</label>
                            <select name="salle_id" id="salle_id" class="form-control">
                                <option value="">Toutes les salles</option>
                                @foreach($salles as $salle)
                                    <option value="{{ $salle->id }}" {{ $salle_id == $salle->id ? 'selected' : '' }}>
                                        {{ $salle->nom }}
                                    </option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-3 mb-2">
                            <label for="departement_id">Département</label>
                            <select name="departement_id" id="departement_id" class="form-control">
                                <option value="">Tous les départements</option>
                                @foreach($departements as $departement)
                                    <option value="{{ $departement->id }}" {{ $departement_id == $departement->id ? 'selected' : '' }}>
                                        {{ $departement->nom }}
                                    </option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-md-2 mb-2">
                            <label for="date_debut">Date début</label>
                            <input type="date" name="date_debut" id="date_debut" class="form-control" value="{{ $date_debut }}">
                        </div>
                        <div class="col-md-2 mb-2">
                            <label for="date_fin">Date fin</label>
                            <input type="date" name="date_fin" id="date_fin" class="form-control" value="{{ $date_fin }}">
                        </div>
                        <div class="col-md-2 mb-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary">Filtrer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
   
    {{-- <div class="row mb-3">
        <div class="col-md-12">
            <div class="btn-group">
                <a href="{{ route('planning.export-pdf', [
                    'salle_id' => $salle_id, 
                    'departement_id' => $departement_id,
                    'date_debut' => $date_debut,
                    'date_fin' => $date_fin
                ]) }}" class="btn btn-danger">
                    <i class="fas fa-file-pdf"></i> Exporter en PDF
                </a>
            </div>
        </div>
    </div> --}}

    <div class="row mb-3">
        <div class="col-md-12">
            <div class="btn-group">
                <a href="{{ route('reservations.create') }}" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i> faire une demande de reservation 
                </a>
            </div>
        </div>
    </div>
    
    
    @if(session('success'))
        <div class="alert alert-success">
            {{ session('success') }}
        </div>
    @endif

    @foreach($planningData as $date => $planning)
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4>{{ $planning['jour'] }} {{ $planning['date'] }}</h4>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered mb-0">
                            <thead class="thead-light table-wrapper1">
                                <tr>
                                    <th>Demandeur</th>
                                    <th>Horaire</th>
                                    <th>Objet</th>
                                    <th>Nombre Personnes</th>
                                    <th>salle</th>
                                    <th>departement</th>
                                 
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($planning['reservations'] as $reservation)
                                    <tr>
                                        <td>{{ optional($reservation->demandeur)->name ?? '-' }}</td>
                                        <td>
                                            Du {{ \Carbon\Carbon::parse($reservation->date_debut)->format('d/m/Y') }}
                                            à {{ \Carbon\Carbon::parse($reservation->heure_debut)->format('H:i') }}<br>
                                            au {{ \Carbon\Carbon::parse($reservation->date_fin)->format('d/m/Y') }}
                                            à {{ \Carbon\Carbon::parse($reservation->heure_fin)->format('H:i') }}
                                        </td>
                                        <td>{{ $reservation->objet_reunion }}</td>
                                        <td>{{ $reservation->nombreParticipants ?? '-' }}</td>
                                        <td>{{ optional($reservation->salle)->nom ?? '-' }}</td>
                                        <td>{{ optional(optional($reservation->demandeur)->departement)->nom ?? '-' }}</td>
                                    
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="6" class="text-center">Aucune réservation pour cette journée</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endforeach
</div>

<!-- Modal Email -->
<div class="modal fade" id="emailModal" tabindex="-1" role="dialog" aria-labelledby="emailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="{{ route('planning.send-email') }}" method="POST">
                @csrf
                <input type="hidden" name="salle_id" value="{{ $salle_id }}">
                <input type="hidden" name="departement_id" value="{{ $departement_id }}">
                <input type="hidden" name="date_debut" value="{{ $date_debut }}">
                <input type="hidden" name="date_fin" value="{{ $date_fin }}">
                
                <div class="modal-header">
                    <h5 class="modal-title" id="emailModalLabel">Envoyer le planning par email</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="email">Adresse email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Envoyer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    $(document).ready(function() {
        // Auto-submit lors du changement de filtre
        $('#salle_id, #departement_id, #date_debut, #date_fin').change(function() {
            $(this).closest('form').submit();
        });
    });
</script>
@endsection
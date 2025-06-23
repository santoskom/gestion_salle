@extends('layoutss.template')

@section('title', 'Réservations en attente')

@section('content')
<div class="container-xl">


   {{-- @include('partials.error-messagess') --}}
   @include('partials.error-messages')

<!-- Pour les messages de succès -->
@if(session('success'))
    <div class="alert alert-success">
        {{ session('success') }}
    </div>
@endif

<!-- Pour les erreurs -->
@if($errors->any())
    <div class="alert alert-danger">
        @foreach($errors->all() as $error)
            <p>{{ $error }}</p>
        @endforeach
    </div>
@endif


    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Réservations en attente
                </h2>
            </div>
        </div>
    </div>

    
    <div class="card">
        <div class="card-body">
            @if($reservations->count() > 0)
                <div class="table-responsive">
                    <table class="table table-vcenter card-table">
                        <thead>
                            <tr>
                                <th>Salle</th>
                                <th>Objet</th>
                                <th>Date</th>
                                <th>Horaire</th>
                                <th>Demandeur</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($reservations as $reservation)
                                <tr>
                                    <td>{{ $reservation->salle->nom }}</td>
                                    <td>{{ $reservation->objet_reunion }}</td>
                                    <td>
                                    @php
                                        $dateDebut = \Carbon\Carbon::parse($reservation->date_debut);
                                        $dateFin = \Carbon\Carbon::parse($reservation->date_fin);
                                    @endphp
                                    
                                    @if($dateDebut->isSameDay($dateFin))
                                        {{ $dateDebut->translatedFormat('d/m/Y') }}
                                    @else
                                        {{ $dateDebut->translatedFormat('d/m/Y') }} au {{ $dateFin->translatedFormat('d/m/Y') }}
                                    @endif
                                </td>
                                <td>
                                    {{ $dateDebut->format('H:i') }} - {{ $dateFin->format('H:i') }}
                                </td>
                                    <td>{{ $reservation->demandeur->name ?? '—' }}</td>
                                    <td class="text-end">
                                        <div class="btn-group">
                                            
                                            <button type="button" class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#validerModal{{ $reservation->id }}">
                                                <i class="ti ti-check"></i> Valider
                                            </button>
                                            <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#refuserModal{{ $reservation->id }}">
                                                <i class="ti ti-x"></i> Refuser
                                            </button>
                                        </div>
                                        
                                        <!-- Modal de validation -->
                                        <div class="modal fade" id="validerModal{{ $reservation->id }}" tabindex="-1" role="dialog" aria-labelledby="validerModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="validerModalLabel">Confirmer la validation</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body text-start">
                                                        <p>Êtes-vous sûr de vouloir valider cette réservation ?</p>
                                                        <p><strong>Salle :</strong> {{ $reservation->salle->nom }}</p>
                                                        <p><strong>Objet :</strong> {{ $reservation->objet_reunion }}</p>
                                                        <p><strong>Date :</strong> 
                                                            @if($reservation->date_debut == $reservation->date_fin)
                                                                {{ date('d/m/Y', strtotime($reservation->date_debut)) }}
                                                            @else
                                                                {{ date('d/m/Y', strtotime($reservation->date_debut)) }} au {{ date('d/m/Y', strtotime($reservation->date_fin)) }}
                                                            @endif
                                                        </p>
                                                        <p><strong>Horaire :</strong> {{ $reservation->heure_debut }} - {{ $reservation->heure_fin }}</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                        <form action="{{ route('reservations.valider', $reservation) }}" method="POST" style="display: inline;">
                                                            @csrf
                                                            @method('PATCH')
                                                            <button type="submit" class="btn btn-success">Valider</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Modal de refus -->
                                        <div class="modal fade" id="refuserModal{{ $reservation->id }}" tabindex="-1" role="dialog" aria-labelledby="refuserModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="refuserModalLabel">Confirmer le refus</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body text-start">
                                                        <p>Êtes-vous sûr de vouloir refuser cette réservation ?</p>
                                                        <p><strong>Salle :</strong> {{ $reservation->salle->nom }}</p>
                                                        <p><strong>Objet :</strong> {{ $reservation->objet_reunion }}</p>
                                                        <p><strong>Date :</strong> 
                                                            @if($reservation->date_debut == $reservation->date_fin)
                                                                {{ date('d/m/Y', strtotime($reservation->date_debut)) }}
                                                            @else
                                                                {{ date('d/m/Y', strtotime($reservation->date_debut)) }} au {{ date('d/m/Y', strtotime($reservation->date_fin)) }}
                                                            @endif
                                                        </p>
                                                        <p><strong>Horaire :</strong> {{ $reservation->heure_debut }} - {{ $reservation->heure_fin }}</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                        <form action="{{ route('reservations.refuser', $reservation) }}" method="POST" style="display: inline;">
                                                            @csrf
                                                            @method('PATCH')
                                                            <button type="submit" class="btn btn-danger">Refuser</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <div class="mt-3">
                    {{ $reservations->links() }}
                </div>
            @else
                <div class="empty">
                    <div class="empty-icon">
                        <i class="ti ti-calendar-off"></i>
                    </div>
                    <p class="empty-subtitle text-muted">
                        Il n'y a actuellement aucune demande de réservation en attente de validation.
                    </p>
                </div>
            @endif
        </div>
    </div>
</div>
@endsection
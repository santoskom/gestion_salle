

@extends('layoutss.template')

@section('content')

<div class="row g-3 mb-4 align-items-center justify-content-between">
    <div class="col-auto">
        <h1 class="app-page-title mb-0">Reservations</h1>
    </div>
                   
    <div class="col-auto">
        <div class="page-utilities">
            <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
                <div class="col-auto">
                    <form class="table-search-form row gx-1 align-items-center" method="GET" action="{{ route('reservations.search') }}">
                        <div class="col-auto">
                            <input type="text" 
                                id="search-orders" 
                                name="searchorders" 
                                class="form-control search-orders" 
                                placeholder="Rechercher par objet, salle ou demandeur"
                                value="{{ request('searchorders') ?? $searchTerm ?? '' }}">
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn app-btn-secondary">Rechercher</button>
                        </div>
                        @if(request('searchorders') || isset($searchTerm))
                        <div class="col-auto">
                            <a href="{{ route('reservations.index') }}" class="btn btn-outline-secondary">Effacer</a>
                        </div>
                        @endif
                    </form>

                    @if(isset($searchTerm))
                    <div class="mt-2">
                        <small class="text-muted">
                            Résultats pour : <strong>{{ $searchTerm }}</strong>
                            ({{ $reservations->total() }} résultat{{ $reservations->total() > 1 ? 's' : '' }})
                        </small>
                    </div>
                    @endif
                </div>
                
                <div class="col-auto">                          
                    <a class="btn app-btn-secondary" href="{{route('reservations.create')}}">
                        Ajouter une reservation 
                    </a>
                    
                    <!-- Bouton pour la suppression multiple -->
                    <button type="button" class="btn btn-danger" id="deleteMultipleBtn" disabled>
                        Supprimer la sélection
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

 @include('partials.error-messages')
 {{-- @include('partials.error-messagess') --}}

<div class="tab-content" id="orders-table-tab-content">
    <div class="tab-pane fade show active" id="orders-all" role="tabpanel" aria-labelledby="orders-all-tab">
        <div class="app-card app-card-orders-table shadow-sm mb-5">
            <div class="app-card-body">
                <form id="massDeleteForm" action="{{ route('reservations.massDestroy') }}" method="POST">
                    @csrf
                    @method('DELETE')
                    <div class="table-responsive table-wrapper">
                        <table class="table app-table-hover mb-0 text-left table-wrapper1">
                            <thead>
                                <tr>
                                    <th width="40">
                                        <input type="checkbox" id="selectAll">
                                    </th>
                                    <th>Salle</th>
                                    <th>Titre</th>
                                    <th>Date & Heure début</th>
                                    <th>Date & Heure fin</th>
                                    <th>Demandeur</th>
                                    <th>Description</th>
                                    <th>Statut</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($reservations as $res)
                                    <tr>
                                        <td>
                                            <input type="checkbox" name="ids[]" value="{{ $res->id }}" class="checkbox">
                                        </td>
                                        <td>{{ $res->salle->nom ?? 'Non spécifié' }}</td>
                                        <td>{{ $res->objet_reunion }}</td>
                                        <td>
                                            @php
                                                $dateDebut = \Carbon\Carbon::parse($res->date_debut);
                                                $dateFin = \Carbon\Carbon::parse($res->date_fin);
                                            @endphp
                                            
                                            @if($dateDebut->isSameDay($dateFin))
                                                {{ $dateDebut->translatedFormat('d/m/Y') }}
                                            @else
                                                {{ $dateDebut->translatedFormat('d/m/Y') }} au {{ $dateFin->translatedFormat('d/m/Y') }}
                                            @endif
                                            <br>
                                            {{ $dateDebut->format('H:i') }}
                                        </td>
                                        <td>
                                            @if(!$dateDebut->isSameDay($dateFin))
                                                {{ $dateFin->translatedFormat('d/m/Y') }}
                                            @endif
                                            <br>
                                            {{ $dateFin->format('H:i') }}
                                        </td>
                                        <td>{{ $res->demandeur->name ?? 'Non spécifié' }}</td>
                                        <td class="truncate">{{ $res->description ?? 'Non spécifié' }}</td>
                                        <td>
                                            @if($res->statut === 'valide')
                                                <span class="badge bg-success">Validée</span>
                                            @elseif($res->statut === 'en_attente')
                                                <span class="badge bg-warning text-dark">En attente</span>
                                            @elseif($res->statut === 'refusee')
                                                <span class="badge bg-danger">Refusée</span>
                                            @elseif($res->statut === 'annulee')
                                                <span class="badge bg-secondary">Annulée</span>
                                            @else
                                                <span class="badge bg-primary">{{ $res->statut }}</span>
                                            @endif
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                @if ($res->isPending() && (auth()->id() === $res->id_demandeur || auth()->user()->isAssistantDirection()))
                                                    <a class="btn btn-sm btn-warning" href="{{ route('reservations.edit', $res) }}">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                                            <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"/>
                                                        </svg>
                                                    </a>
                                                @endif
                                                                                                
                                                @if ($res->isPending() && (auth()->id() === $res->id_demandeur || auth()->user()->isAssistantDirection()))
                                                    <button type="button" class="btn btn-danger btn-sm p-2" data-bs-toggle="modal" data-bs-target="#deleteModal{{ $res->id }}">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                                            <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1z"/>
                                                        </svg>
                                                    </button>

                                                    <!-- Modal de confirmation pour suppression unitaire -->
                                                    <div class="modal fade" id="deleteModal{{ $res->id }}" tabindex="-1" aria-labelledby="deleteModalLabel{{ $res->id }}" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="deleteModalLabel{{ $res->id }}">Confirmer la suppression</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                                                                </div>
                                                                <div class="modal-body text-start">
                                                                    <p>Êtes-vous sûr de vouloir <strong>supprimer</strong> cette réservation ?</p>
                                                                    <p><strong>Salle :</strong> {{ $res->salle->nom }}</p>
                                                                    <p><strong>Objet :</strong> {{ $res->objet_reunion }}</p>
                                                                    <p><strong>Date :</strong>
                                                                        @if($res->date_debut == $res->date_fin)
                                                                            {{ date('d/m/Y', strtotime($res->date_debut)) }}
                                                                        @else
                                                                            {{ date('d/m/Y', strtotime($res->date_debut)) }} au {{ date('d/m/Y', strtotime($res->date_fin)) }}
                                                                        @endif
                                                                    </p>
                                                                    <p><strong>Horaire :</strong> {{ $res->heure_debut }} - {{ $res->heure_fin }}</p>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                                                    <form action="{{ route('reservations.destroy', $res) }}" method="POST">
                                                                        @csrf
                                                                        @method('DELETE')
                                                                        <button type="submit" class="btn btn-danger">Supprimer</button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                @endif
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="9">Aucune réservation trouvée</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </form>
                
                <nav class="app-pagination">
                    {{ $reservations->links() }}
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- Modal de confirmation pour suppression multiple -->
<div class="modal fade" id="deleteMultipleModal" tabindex="-1" aria-labelledby="deleteMultipleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteMultipleModalLabel">Confirmer la suppression multiple</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
            </div>
            <div class="modal-body">
                <p>Êtes-vous sûr de vouloir supprimer les <span id="selectedCount">0</span> réservations sélectionnées ?</p>
                <p class="text-danger">Cette action est irréversible.</p>
                <div id="selectedReservations" class="mt-3 small text-muted">
                    <!-- Les réservations sélectionnées seront affichées ici -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-danger" id="confirmMultipleDelete">Supprimer</button>
            </div>
        </div>
    </div>
</div>

@endsection
@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Sélection/désélection de toutes les cases
    $('#selectAll').click(function() {
        $('.checkbox').prop('checked', this.checked);
        toggleDeleteButton();
        updateSelectedInfo();
    });
    
    // Gestion de la case "Tout sélectionner" quand on coche/décoche manuellement
    $('.checkbox').change(function() {
        if ($('.checkbox:checked').length === $('.checkbox').length) {
            $('#selectAll').prop('checked', true);
        } else {
            $('#selectAll').prop('checked', false);
        }
        toggleDeleteButton();
        updateSelectedInfo();
    });
    
    // Activer/désactiver le bouton de suppression
    function toggleDeleteButton() {
        const checkedCount = $('.checkbox:checked').length;
        $('#deleteMultipleBtn').prop('disabled', checkedCount === 0);
        $('#deleteMultipleBtn').text(checkedCount > 0 ? 
            `Supprimer (${checkedCount})` : 'Supprimer la sélection');
    }
    
    // Mettre à jour les informations dans la modale
    function updateSelectedInfo() {
        const checkedBoxes = $('.checkbox:checked');
        const count = checkedBoxes.length;
        $('#selectedCount').text(count);
        
        let reservationsList = '';
        checkedBoxes.each(function() {
            const row = $(this).closest('tr');
            const salle = row.find('td:nth-child(2)').text();
            const titre = row.find('td:nth-child(3)').text();
            const date = row.find('td:nth-child(4)').text().trim();
            
            reservationsList += `<div>${titre} - ${salle} (${date})</div>`;
        });
        
        $('#selectedReservations').html(reservationsList);
    }
    
    // Ouvrir la modale de confirmation
    $('#deleteMultipleBtn').click(function() {
        updateSelectedInfo();
        $('#deleteMultipleModal').modal('show');
    });
    
    // Confirmer la suppression
    $('#confirmMultipleDelete').click(function() {
        $('#massDeleteForm').submit();
    });
    
    // Empêcher la soumission du formulaire si aucune case n'est cochée
    $('#massDeleteForm').submit(function(e) {
        if ($('.checkbox:checked').length === 0) {
            e.preventDefault();
            alert('Veuillez sélectionner au moins une réservation à supprimer.');
        }
    });
});
</script>
@endpush
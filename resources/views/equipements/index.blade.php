@extends('layoutss.template')

@section('content')

<div class="row g-3 mb-4 align-items-center justify-content-between">
				    <div class="col-auto">
			            <h1 class="app-page-title mb-0">equipements</h1>
				    </div>
				    <div class="col-auto">
					     <div class="page-utilities">
						    <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
							    <div class="col-auto">
								   
					                
							    </div><!--//col-->
							    
							    <div class="col-auto">						    
								    <a class="btn app-btn-secondary" href="{{route('equipements.create')}}">
													ajouter un equipement
									</a>
							    </div>
						    </div><!--//row-->
					    </div><!--//table-utilities-->
				    </div><!--//col-auto-->
			    </div><!--//row-->
			     @include('partials.error-messages')
			    
			   
				
				<div class="tab-content" id="orders-table-tab-content">
			        <div class="tab-pane fade show active" id="orders-all" role="tabpanel" aria-labelledby="orders-all-tab">
					    <div class="app-card app-card-orders-table shadow-sm mb-5">
						    <div class="app-card-body">
							    <div class="table-responsive">
							        <table class="table app-table-hover mb-0 text-left table-wrapper1">
										<thead>
											<tr>
												<th class="cell">Nom</th>
												<th class="cell">Description</th>
												<th class="cell">Numéro de série</th>
												<th class="cell">Modèle</th>
												<th class="cell">Marque</th>
												<th class="cell">Actions</th>
											</tr>
										</thead>
										<tbody>
											@forelse($equipements as $equipement)
											<tr>
												<td class="cell"><span class="truncate">{{$equipement->nom}}</span></td>
												<td class="cell"><span class="truncate">{{$equipement->description}}</span></td>
												<td class="cell"><span class="truncate">{{$equipement->numero_serie}}</span></td>
												<td class="cell"><span class="truncate">{{$equipement->modele}}</span></td>
												<td class="cell"><span class="truncate">{{$equipement->marque ?? '-'}}</span></td>
												<td class="cell">
													<a class="btn btn-sm btn-warning text-white" href="{{route('equipements.edit', $equipement->id)}}">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
														<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"/>
													  </svg>
													</a>

													  <button type="button" class="btn btn-danger btn-sm p-2" data-bs-toggle="modal" data-bs-target="#deleteModal{{ $equipement->id }}">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
															<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1z"/>
															<path d="M3 5.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 .5.5v.5H3v-.5z"/>
														</svg>
													</button>
													   <!-- Modal de confirmation -->
									<div class="modal fade" id="deleteModal{{ $equipement->id }}" tabindex="-1" aria-labelledby="deleteModalLabel{{ $equipement->id }}" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="deleteModalLabel{{ $equipement->id }}">Confirmer la suppression</h5>
													<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
												</div>
												<div class="modal-body text-start">
													<p>Êtes-vous sûr de vouloir <strong>supprimer</strong> cette equipement ?</p>
													<p><strong>Nom :</strong> {{ $equipement->nom }}</p>
													<p><strong>Description :</strong> {{ $equipement->description}}</p>
													<p><strong>Marque :</strong> {{ $equipement->marque}}</p>
													<p><strong>Modèle :</strong> {{ $equipement->modele}}</p>
													
													
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
													<form action="{{ route('equipements.delete', $equipement) }}" method="POST">
														@csrf
														@method('DELETE')
														<button type="submit" class="btn btn-danger">Supprimer</button>
													</form>
												</div>
											</div>
										</div>
												</td>
											</tr>
											@empty
											<tr>
												<td class="cell" colspan="6">Aucun équipement ajouté</td>
											</tr>
											@endforelse
										</tbody>
									</table>
						        </div><!--//table-equipementponsive-->
						       
						    </div><!--//app-card-body-->		
						</div><!--//app-card-->
						<nav class="app-pagination">
							{{$equipements->Links()}}
						</nav><!--//app-pagination-->
						
			        </div><!--//tab-pane-->
			        
			        <div class="tab-pane fade" id="orders-paid" role="tabpanel" aria-labelledby="orders-paid-tab">
					   
				</div><!--//tab-content-->


@endsection
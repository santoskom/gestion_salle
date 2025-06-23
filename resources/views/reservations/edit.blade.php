@extends('layoutss.template')

@section('content')

<h1 class="app-page-title">reservation</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
                  {{--  --}}
                      

							{{-- Affichage des erreurs formatées --}}
			{{-- Affichage unifié des messages flash (succès et erreurs) --}}
					@if(session('succes_message'))
						<div class="alert alert-{{ session('succes_message.type', 'success') }} alert-dismissible fade show mb-4" role="alert">
							<div class="d-flex align-items-start">
								<i class="fas {{ session('succes_message.icon', 'fa-check-circle') }} me-3 mt-1 fs-5"></i>
								<div class="flex-grow-1">
									<h6 class="alert-heading mb-2">{{ session('succes_message.title', 'Succès') }}</h6>
									<p class="mb-0">{{ session('succes_message.message') }}</p>
								</div>
							</div>
							<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
						</div>
					@endif

					@if(session('formatted_errors'))
						@foreach(session('formatted_errors') as $field => $error)
							<div class="alert alert-{{ $error['type'] ?? 'danger' }} alert-dismissible fade show mb-3" role="alert">
								<div class="d-flex align-items-start">
									<i class="fas {{ $error['icon'] ?? 'fa-exclamation-circle' }} me-3 mt-1 fs-5"></i>
									<div class="flex-grow-1">
										<h6 class="alert-heading mb-2">{{ $error['title'] ?? 'Erreur' }}</h6>
										<p class="mb-0">{{ $error['message'] }}</p>
										
										@if($field !== 'general')
											<small class="text-muted d-block mt-1">
												<i class="fas fa-tag me-1"></i>
												Champ concerné: {{ ucfirst(str_replace('_', ' ', $field)) }}
											</small>
										@endif
									</div>
								</div>
								<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
							</div>
						@endforeach
					@endif
								{{--  --}}
	               @include('partials.error-messages')
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('reservations.update',$reservation->id)}}">

								@csrf

								@method('PUT')
								<div class="card shadow-sm">
									<div class="card-header bg-primary text-white">
										<h5 class="card-title mb-0">Modifier la réservation</h5>
									</div>
									<div class="card-body">
										<div class="mb-3">
											<label for="salle_id" class="form-label">Salle <span class="text-danger">*</span></label>
											<select name="salle_id" id="salle_id" class="form-select @error('salle_id') is-invalid @enderror" required>
												<option value="">Choisir une salle</option>
												@foreach($salles as $salle)
													<option value="{{ $salle->id }}" 
															data-capacite="{{ $salle->capacite }}"
															{{ (old('salle_id', $reservation->salle_id) == $salle->id) ? 'selected' : '' }}>
														{{ $salle->nom }} (Capacité: {{ $salle->capacite }} personnes)
													</option>
												@endforeach
											</select>
											@error('salle_id')
												<div class="invalid-feedback">{{ $message }}</div>
											@enderror
											<div id="salle_details" class="text-muted mt-2"></div>
										</div>
										
											<div class="row mb-3">
											<div class="col-md-6">
												<label for="date_debut" class="form-label">Date et heure de début <span class="text-danger">*</span></label>
												<input type="datetime-local" class="form-control @error('date_debut') is-invalid @enderror" 
													id="date_debut" name="date_debut" 
													value="{{ old('date_debut', $reservation->date_debut->format('Y-m-d\TH:i')) }}" 
													min="{{ now()->format('Y-m-d\TH:i') }}" required>
												@error('date_debut')
													<div class="invalid-feedback">{{ $message }}</div>
												@enderror
											</div>
											<div class="col-md-6">
												<label for="date_fin" class="form-label">Date et heure de fin <span class="text-danger">*</span></label>
												<input type="datetime-local" class="form-control @error('date_fin') is-invalid @enderror" 
													id="date_fin" name="date_fin" 
													value="{{ old('date_fin', $reservation->date_fin->format('Y-m-d\TH:i')) }}" 
													min="{{ now()->format('Y-m-d\TH:i') }}" required>
												@error('date_fin')
													<div class="invalid-feedback">{{ $message }}</div>
												@enderror
											</div>
										</div>
										
										<div class="mb-3">
											<label for="objet_reunion" class="form-label">Objet de la réunion <span class="text-danger">*</span></label>
											<input type="text" class="form-control @error('objet_reunion') is-invalid @enderror" 
												   id="objet_reunion" name="objet_reunion" value="{{ old('objet_reunion', $reservation->objet_reunion) }}" required>
											@error('objet_reunion')
												<div class="invalid-feedback">{{ $message }}</div>
											@enderror
										</div>
										
										<div class="mb-3">
											<label for="description" class="form-label">Description</label>
											<textarea class="form-control @error('description') is-invalid @enderror" 
													  id="description" name="description" rows="3">{{ old('description', $reservation->description) }}</textarea>
											@error('description')
												<div class="invalid-feedback">{{ $message }}</div>
											@enderror
										</div>
										
										<div class="mb-3">
											<label for="nombreParticipants" class="form-label">Nombre de participants <span class="text-danger">*</span></label>
											<input type="number" class="form-control @error('nombreParticipants') is-invalid @enderror" 
												   id="nombreParticipants" name="nombreParticipants" value="{{ old('nombreParticipants', $reservation->nombreParticipants) }}" min="1" required>
											@error('nombreParticipants')
												<div class="invalid-feedback">{{ $message }}</div>
											@enderror
											<div id="capacite_warning" class="text-danger mt-1 d-none">
												<i class="fas fa-exclamation-triangle me-1"></i>
												Le nombre de participants dépasse la capacité de la salle !
											</div>
										</div>
										
										<div class="mb-4">
											<label class="form-label">Équipements nécessaires</label>
											<div class="row">
												@foreach($equipements as $equipement)
													<div class="col-md-4 mb-2">
														<div class="form-check">
															<input class="form-check-input" type="checkbox" name="equipements[]" 
																   value="{{ $equipement->id }}" id="equipement{{ $equipement->id }}"
																   {{ in_array($equipement->id, old('equipements', $reservation->equipements->pluck('id')->toArray())) ? 'checked' : '' }}>
															<label class="form-check-label" for="equipement{{ $equipement->id }}">
																{{ $equipement->nom }}
															</label>
														</div>
													</div>
												@endforeach
											</div>
										</div>
										
										<div class="mb-4">
											<div class="form-check">
												<input class="form-check-input" type="checkbox" name="rappel_active" 
													   value="1" id="rappel_active" {{ old('rappel_active', $reservation->rappel_active) ? 'checked' : '' }}>
												<label class="form-check-label" for="rappel_active">
													Activer le rappel automatique (30 minutes avant la réunion)
												</label>
											</div>
										</div>
										
										<div class="d-flex justify-content-between mt-4">
											<a href="{{ route('reservations.index') }}" class="btn btn-secondary">
												<i class="fas fa-arrow-left me-1"></i> Annuler
											</a>
											<button type="submit" class="btn btn-primary">
												<i class="fas fa-save me-1"></i> Mettre à jour la réservation
											</button>
										</div>
									</div>
								</div>
							</form>
						    </div><!--//app-card-body-->
						    
						</div><!--//app-card-->
	                </div>
                </div><!--//row-->

				@push('scripts')
					<script src="{{ asset('assets/js/reserv.js') }}"></script>
				@endpush
					@push('scripts')
				 <script src="{{ asset('assets/js/actualisation.js') }}"></script>
			@endpush
					@push('scripts')
				    <script src="{{ asset('assets/js/closedate.js') }}"></script>
			@endpush
@endsection
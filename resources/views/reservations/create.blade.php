@extends('layoutss.template')

@section('content')

<h1 class="app-page-title">demandé une salle </h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
					@if ($errors->has('conflict'))
						<div class="alert alert-danger">
							{{ $errors->first('conflict') }}
						</div>
					@endif
					
		@include('partials.error-messages')
		{{-- @include('partials.error-messagess') --}}
					@if ($errors->has('duree'))
						<div class="alert alert-danger">
							{{ $errors->first('duree') }}
						</div>
					@endif
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('reservations.store')}}">

								@csrf

								@method('POST')
        
								<div class="mb-3">
									<label for="salle_id" class="form-label">Salle <span class="text-danger">*</span></label>
									<select name="salle_id" id="salle_id" class="form-select @error('salle_id') is-invalid @enderror" required>
										<option value="">Choisir une salle</option>
										@foreach($salles as $salle)
											<option value="{{ $salle->id }}" 
													data-capacite="{{ $salle->capacite }}"
													{{ old('salle_id') == $salle->id ? 'selected' : '' }}>
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
									<label for="date_debut" class="form-label">Date de début <span class="text-danger">*</span></label>
									<input type="datetime-local" class="form-control @error('date_debut') is-invalid @enderror" 
										id="date_debut" name="date_debut" value="{{ old('date_debut') }}" 
										min="{{ now()->format('Y-m-d\TH:i') }}" required>
									@error('date_debut')
										<div class="invalid-feedback">{{ $message }}</div>
									@enderror
								</div>
								<div class="col-md-6">
									<label for="date_fin" class="form-label">Date de fin <span class="text-danger">*</span></label>
									<input type="datetime-local" class="form-control @error('date_fin') is-invalid @enderror" 
										id="date_fin" name="date_fin" value="{{ old('date_fin') }}" 
										min="{{ now()->format('Y-m-d\TH:i') }}" required>
									@error('date_fin')
										<div class="invalid-feedback">{{ $message }}</div>
									@enderror
								</div>
							</div>	
								<div class="mb-3">
									<label for="objet_reunion" class="form-label">Objet de la réunion <span class="text-danger">*</span></label>
									<input type="text" class="form-control @error('objet_reunion') is-invalid @enderror" 
										   id="objet_reunion" name="objet_reunion" value="{{ old('objet_reunion') }}" required>
									@error('objet_reunion')
										<div class="invalid-feedback">{{ $message }}</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="description" class="form-label">Description</label>
									<textarea class="form-control @error('description') is-invalid @enderror" 
											  id="description" name="description" rows="3">{{ old('description') }}</textarea>
									@error('description')
										<div class="invalid-feedback">{{ $message }}</div>
									@enderror
								</div>
								
								 <div class="mb-3">
									<label for="nombreParticipants" class="form-label">Nombre de participants <span class="text-danger">*</span></label>
									<input type="number" class="form-control @error('nombreParticipants') is-invalid @enderror" 
										id="nombreParticipants" name="nombreParticipants" value="{{ old('nombreParticipants') }}" min="1" required>
									@error('nombreParticipants')
										<div class="invalid-feedback">{{ $message }}</div>
									@enderror
									<div id="capacite_info" class="text-muted mt-1">
										Capacité maximale: <span id="capacite_max">{{ $salles->first()->capacite ?? 0 }}</span> personnes
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
														   {{ in_array($equipement->id, old('equipements', [])) ? 'checked' : '' }}>
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
											   value="1" id="rappel_active" {{ old('rappel_active') ? 'checked' : '' }}>
										<label class="form-check-label" for="rappel_active">
											Activer le rappel automatique (30 minutes avant la réunion)
										</label>
									</div>
								</div>
								
								<div class="d-flex justify-content-end">
									<a href="{{ route('reservations.index') }}" class="btn btn-secondary me-2">
										<i class="fas fa-times me-1"></i>Annuler
									</a>
									<button type="submit" class="btn btn-primary">
										<i class="fas fa-save me-1"></i>Enregistrer la demande
									</button>
								</div>

							    </form>
						    </div><!--//app-card-body-->
						    
						</div><!--//app-card-->
	                </div>
                </div><!--//row-->

				

					@push('scripts')
				 <script src="{{ asset('assets/js/actualisation.js') }}"></script>
				 <script src="{{ asset('assets/js/closedate.js') }}"></script>
				 <script src="{{ asset('assets/js/reservation-validator.js') }}"></script>
				 {{-- <script src="{{ asset('assets/js/conflit.js') }}"></script> --}}

				
			@endpush
@endsection
@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">salle</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
	               
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('salles.store')}}">

								@csrf

								@method('POST')
								    
									<!-- NOM -->
									<div class="mb-3">
										<label for="nom" class="form-label">Nom <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="nom" name="nom"
											value="{{ old('nom') }}" placeholder="Entrer le nom de la salle" required>
										@error('nom')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>
                                    
									<!-- CAPACITÉ -->
									<div class="mb-3">
										<label for="capacite" class="form-label">Capacité <span class="text-danger">*</span></label>
										<input type="number" class="form-control" id="capacite" name="capacite"
											value="{{ old('capacite') }}" placeholder="Nombre de personnes maximum">
										@error('capacite')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>

									<!-- LOCALISATION -->
									<div class="mb-3">
										<label for="localisation" class="form-label">Localisation <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="localisation" name="localisation"
											value="{{ old('localisation') }}" placeholder="Exemple : Bâtiment A, 2e étage">
										@error('localisation')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>

									<!-- DESCRIPTION -->
									<div class="mb-3">
										<label for="description" class="form-label">Description</label>
										<textarea class="form-control" id="description" name="description" rows="3"
											placeholder="Détails de la salle">{{ old('description') }}</textarea>
										@error('description')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>

			
									<button type="submit"  class="btn app-btn-primary" >ajouter</button>
							    </form>
						    </div><!--//app-card-body-->
						    
						</div><!--//app-card-->
	                </div>
                </div><!--//row-->
@endsection
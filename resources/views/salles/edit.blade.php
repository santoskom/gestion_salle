@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">Edit salle</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
	               
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('salles.update', $salle->id)}}">

								@csrf

								@method('PUT')
								    
									
									<!-- Champ : Nom -->
									<div class="mb-3">
										<label for="nom" class="form-label">Nom</label>
										<input type="text" class="form-control" id="nom" name="nom"
											value="{{$salle->nom}}"
											placeholder="Entrer le nom de la salle" required>
										@error('nom')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>
                                    
									
									<!-- Champ : Capacité -->
									<div class="mb-3">
										<label for="capacite" class="form-label">Capacité</label>
										<input type="number" class="form-control" id="capacite" name="capacite"
											value="{{  $salle->capacite}}"
											placeholder="Capacité de la salle">
										@error('capacite')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>

									<!-- Champ : Localisation -->
									<div class="mb-3">
										<label for="localisation" class="form-label">Localisation</label>
										<input type="text" class="form-control" id="localisation" name="localisation"
											value="{{$salle->localisation }}"
											placeholder="Localisation de la salle">
										@error('localisation')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>

									<!-- Champ : Description -->
									<div class="mb-3">
										<label for="description" class="form-label">Description</label>
										<textarea class="form-control" id="description" name="description" rows="3"
												placeholder="Description de la salle">{{ $salle->description }}</textarea>
										@error('description')
											<div class="text-danger">{{ $message }}</div>
										@enderror
									</div>

								
									<button type="submit"  class="btn app-btn-primary" >mise a jour</button>
							    </form>
						    </div><!--//app-card-body-->
						    
						</div><!--//app-card-->
	                </div>
                </div><!--//row-->
@endsection
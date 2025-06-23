@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">Edit equipement</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
	               
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('equipements.update', $equipement->id)}}">

								@csrf

								@method('PUT')
								    
								<div class="mb-3">
									<label for="setting-input-nom" class="form-label">Nom</label>
									<input type="text" class="form-control" id="setting-input-nom" name="nom" 
										value="{{ old('nom', $equipement->nom ?? '') }}"
										placeholder="Entrer le nom de l'équipement" required>
									@error('nom')
										<div class="text-danger">{{ $message }}</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-description" class="form-label">Description</label>
									<input type="text" class="form-control" id="setting-input-description" name="description" 
										value="{{ old('description', $equipement->description ?? '') }}"
										placeholder="Entrer la description de l'équipement">
									@error('description')
										<div class="text-danger">{{ $message }}</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-numero_serie" class="form-label">Numéro de série</label>
									<input type="text" class="form-control" id="setting-input-numero_serie" name="numero_serie" 
										value="{{ old('numero_serie', $equipement->numero_serie ?? '') }}"
										placeholder="Entrer le numéro de série" required>
									@error('numero_serie')
										<div class="text-danger">{{ $message }}</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-marque" class="form-label">Marque</label>
									<input type="text" class="form-control" id="setting-input-marque" name="marque" 
										value="{{ old('marque', $equipement->marque ?? '') }}"
										placeholder="Entrer la marque de l'équipement">
									@error('marque')
										<div class="text-danger">{{ $message }}</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-modele" class="form-label">Modèle</label>
									<input type="text" class="form-control" id="setting-input-modele" name="modele" 
										value="{{ old('modele', $equipement->modele ?? '') }}"
										placeholder="Entrer le modèle de l'équipement" required>
									@error('modele')
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
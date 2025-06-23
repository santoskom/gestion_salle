@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">departements</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
	               
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('departements.store')}}">

								@csrf

								@method('POST')
								    
								<div class="mb-3">
									<label for="setting-input-nom" class="form-label">Nom <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="setting-input-nom" name="nom" 
										value="{{old('nom')}}"
										placeholder="Entrer le nom du département" required >
									@error('nom')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-description" class="form-label">Description</label>
									<input type="text" class="form-control" id="setting-input-description" name="description" 
										value="{{old('description')}}"
										placeholder="Entrer la description du département">
									@error('description')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-responsable" class="form-label">Responsable <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="setting-input-responsable" name="responsable" 
										value="{{old('responsable')}}"
										placeholder="Entrer le nom du responsable">
									@error('responsable')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-telephone" class="form-label">Téléphone <span class="text-danger">*</span></label>
									<input type="tel" class="form-control" id="setting-input-telephone" name="telephone" pattern="^\+?[0-9]{9,20}$" maxlength="20"
										value="{{old('telephone')}}"
										placeholder="+237XXXXXXXX">
									@error('telephone')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-localisation" class="form-label">Localisation <span class="text-danger">*</span></label>
									<input type="text" class="form-control" id="setting-input-localisation" name="localisation" 
										value="{{old('localisation')}}"
										placeholder="Entrer la localisation (bâtiment, étage...)">
									@error('localisation')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								    
									<button type="submit"  class="btn app-btn-primary" >ajouter</button>
							    </form>
						    </div><!--//app-card-body-->
						    
						</div><!--//app-card-->
	                </div>
                </div><!--//row-->
@endsection
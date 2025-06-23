@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">utilisateurs</h1>
<hr class="mb-4">
<div class="row g-4 settings-section">
	<!-- <div class="col-12 col-md-4">
		<h3 class="section-title">General</h3>
		<div class="section-intro">Settings section intro goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit. </div>
	</div> -->
	<div class="col-12 col-md-8">
		<div class="app-card app-card-settings shadow-sm p-4">
			
			<div class="app-card-body">
				  <form class="settings-form" method="post" action="{{route('admins.store')}}">

								@csrf

								@method('POST')
								<div class="mb-3">
									<label for="setting-input-name" class="form-label">Nom</label>
									<input type="text" class="form-control" id="setting-input-name" name="name" 
										value="{{old('name')}}"
										placeholder="Entrer le nom de l'utilisateur" required >
									@error('name')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-email" class="form-label">Email</label>
									<input type="email" class="form-control" id="setting-input-email" name="email" 
										value="{{old('email')}}"
										placeholder="Entrer l'adresse email" required>
									@error('email')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<label for="setting-input-password" class="form-label">Mot de passe</label>
									<input type="password" class="form-control" id="setting-input-password" name="password" 
										placeholder="Entrer le mot de passe" required>
									@error('password')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								                
								<div class="mb-3">
									<label for="setting-input-company" class="form-label">entreprise</label>
									<select class="form-select" id="setting-input-company" name="company_id">
										<option value="">Sélectionner une entreprise</option>
										@foreach($companys as $company)
											<option value="{{ $company->id }}" {{ old('company_id') == $company->id ? 'selected' : '' }}>
												{{ $company->name }}
											</option>
										@endforeach
									</select>
									@error('company_id')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div> 
								
								<div class="mb-3">
									<label for="setting-input-departement" class="form-label">Département</label>
									<select class="form-select" id="setting-input-departement" name="departement_id">
										<option value="">Sélectionner un département</option>
										@foreach($departements as $departement)
											<option value="{{ $departement->id }}" {{ old('departement_id') == $departement->id ? 'selected' : '' }}>
												{{ $departement->nom }}
											</option>
										@endforeach
									</select>
									@error('departement_id')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								
								<div class="mb-3">
									<label for="setting-input-role" class="form-label">Rôle</label>
									<select class="form-select" id="setting-input-role" name="id_role" required>
										<option value="">Sélectionner un rôle</option>
										@foreach($roles as $role)
											<option value="{{ $role->id }}" {{ old('id_role') == $role->id ? 'selected' : '' }}>
												{{ $role->nom }}
											</option>
										@endforeach
									</select>
									@error('id_role')
										<div class="text-danger"> 
											{{$message}}
										</div>
									@enderror
								</div>
								
								<div class="mb-3">
									<div class="form-check form-switch">
										<input class="form-check-input" type="checkbox" id="setting-input-notifications" name="receive_notifications" value="1" 
											{{ old('receive_notifications', '1') == '1' ? 'checked' : '' }}>
										<label class="form-check-label" for="setting-input-notifications">Recevoir les notifications</label>
									</div>
									@error('receive_notifications')
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
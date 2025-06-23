@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">Edit role</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
	                
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('roles.update', $roles->id)}}">

								@csrf

								@method('PUT')
								    
									<div class="mb-3">
									    <label for="setting-input-2" class="form-label">nom</label>
									    <input type="text" class="form-control" id="setting-input-2" name="nom" 
                                          value="{{$roles->nom}}"
										required >
										 @error('nom')
											<div class="text-danger"> 
												{{$message}}
											</div>
										 @enderror
									</div>
								    
									<button type="submit"  class="btn app-btn-primary" >mise a jour</button>
							    </form>
						    </div><!--//app-card-body-->
						    
						</div><!--//app-card-->
	                </div>
                </div><!--//row-->
@endsection
@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">Edit permission</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
	                <!-- <div class="col-12 col-md-4">
		                <h3 class="section-title">General</h3>
		                <div class="section-intro">Settings section intro goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit. </div>
	                </div> -->
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('permissions.update', $permissions->id)}}">

								@csrf

								@method('PUT')
								    
									<div class="mb-3">
									    <label for="setting-input-2" class="form-label">nom</label>
									    <input type="text" class="form-control" id="setting-input-2" name="nom" 
                                          value="{{$permissions->nom}}"
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
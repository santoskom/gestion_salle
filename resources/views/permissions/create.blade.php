@extends('layoutss.template')

@section('content')


<h1 class="app-page-title">permission</h1>
			    <hr class="mb-4">
                <div class="row g-4 settings-section">
	               
	                <div class="col-12 col-md-8">
		                <div class="app-card app-card-settings shadow-sm p-4">
						    
						    <div class="app-card-body">
							    <form class="settings-form" method="post" action="{{route('permissions.store')}}">

								@csrf

								@method('POST')
								    
									<div class="mb-3">
									    <label for="setting-input-2" class="form-label">nom <span class="text-danger">*</span></label>
									    <input type="text" class="form-control" id="setting-input-2" name="nom" 
                                          value="{{old('nom')}}"
										placeholder="entrer le nom de la permission" required >
										 @error('nom')
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
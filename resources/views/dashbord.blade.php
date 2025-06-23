@extends('layoutss.template')

@section('content')
 
	<h1 class="app-page-title">DASHBOARD </h1>

		@if(count($reminders) > 0)
<div class="alert alert-warning animated-reminder shadow-lg p-4 rounded-3 mt-4">
		<h5 class="fw-bold text-dark mb-3">
			⏰ Réunions commençant dans moins de 20 minutes
		</h5>
		<ul class="mb-0">
			@foreach($reminders as $reservation)
			<li class="mb-2">
				<span class="badge bg-primary me-2">{{ $reservation->salle->nom ?? 'Salle inconnue' }}</span>
				<strong>{{ $reservation->date_debut->format('d/m/Y H:i') }}</strong> →
				{{ $reservation->date_fin->format('H:i') }}
				<span class="ms-2">{{ $reservation->objet_reunion }}</span>
			</li>
			@endforeach
		</ul>
		@push('scripts')
			<script src="{{ asset('assets/js/read.js') }}"></script>
		@endpush
    <audio id="reminderAudio" src="{{ asset('assets/sounds/notification.mp3') }}" preload="auto"></audio>
</div>
		@else
		<div class="alert alert-info mt-4">
			Aucune réunion à venir dans les 20 prochaines minutes{{ $isAssistantDirection ? ' pour les salles de votre entreprise' : '' }}.
		</div>
		@endif
		

			@if(session('error'))
			<div class="alert alert-danger alert-dismissible fade show animated fadeInDown shadow-lg mt-3 mx-3" role="alert" style="border-left: 5px solid #dc3545; background: #fff4f4;">
				<strong><i class="bi bi-shield-lock-fill me-2"></i>Erreur :</strong> {{ session('error') }}
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
			</div>
			@endif  
            @adminOrAssistant
			    <div class="row g-4 mb-4">
				    <div class="col-6 col-lg-3">
					    <div class="app-card app-card-stat shadow-sm h-100">
						    <div class="app-card-body p-3 p-lg-4">
							    <h4 class="stats-type mb-1">Total salle</h4>
							    <div class="stats-figure">{{$totalsalle}}</div>
							    <div class="stats-meta text-success">
								    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-up" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5z"/>
									</svg> {{ $percentageSalle }}%</div>
						    </div><!--//app-card-body-->
						    <a class="app-card-link-mask" href="#"></a>
					    </div><!--//app-card-->
				    </div><!--//col-->
				    
				    <div class="col-6 col-lg-3">
					    <div class="app-card app-card-stat shadow-sm h-100">
						    <div class="app-card-body p-3 p-lg-4">
							    <h4 class="stats-type mb-1">Total reservation</h4>
							    <div class="stats-figure">{{$totalReservation}}</div>
							    <div class="stats-meta text-success">
								    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-down" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
										<path fill-rule="evenodd" d="M8 1a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L7.5 13.293V1.5A.5.5 0 0 1 8 1z"/>
										</svg> {{ $percentageReservations }}% </div>
						    </div><!--//app-card-body-->
						    <a class="app-card-link-mask" href="#"></a>
					    </div><!--//app-card-->
				    </div><!--//col-->
				    <div class="col-6 col-lg-3">
					    <div class="app-card app-card-stat shadow-sm h-100">
						    <div class="app-card-body p-3 p-lg-4">
							    <h4 class="stats-type mb-1">Total utilisateurs </h4>
							    <div class="stats-figure">{{$totalAdministateur}}</div>
							    <div class="stats-meta">
								    </div>
						    </div><!--//app-card-body-->
						    <a class="app-card-link-mask" href="#"></a>
					    </div><!--//app-card-->
				    </div><!--//col-->
				    <div class="col-6 col-lg-3">
					    <div class="app-card app-card-stat shadow-sm h-100">
						    <div class="app-card-body p-3 p-lg-4">
							    <h4 class="stats-type mb-1">reservation en attente</h4>
							    <div class="stats-figure">{{ $totalReservationsEnAttente }}</div>
							    
						    </div><!--//app-card-body-->
						    <a class="app-card-link-mask" href="#"></a>
					    </div><!--//app-card-->
				    </div><!--//col-->
			    </div><!--//row-->
				@endadminOrAssistant

				@adminOrAssistant
				<div class="row g-4 mb-4">
			        <div class="card mt-4">
						<div class="card-header bg-primary text-white">
							Statistiques hebdomadaires des réservations par salle
						</div>
						<div class="card-body">
							<canvas id="salleReservationsWeeklyChart" height="100"></canvas>
						</div>
					</div>
					
					
			<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

			<script>
				const salleReservationDatasets ={!! json_encode($datasets) !!};
			</script>

			@push('scripts')
				 <script src="{{ asset('assets/js/charte.js') }}"></script>
			@endpush
	@endadminOrAssistant


	   
	    

@endsection

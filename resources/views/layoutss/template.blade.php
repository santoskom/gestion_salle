
<!DOCTYPE html>
<html lang="en"> 
<head>
    <title>GEST-SALLE</title>
    
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="csrf-token" content="{{ csrf_token() }}">
    
    <meta name="description" content="Portal - Bootstrap 5 Admin Dashboard Template For Developers">
    <meta name="author" content="Xiaoying Riley at 3rd Wave Media">    
    <link rel="shortcut icon" href="favicon.ico"> 
    
    <!-- FontAwesome JS-->
    <script defer src="{{asset('assets/plugins/fontawesome/js/all.min.js')}}"></script>
     @stack('styles')
    <!-- App CSS -->  
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/6.1.8/index.min.css" rel="stylesheet">
   
    <link id="theme-style" rel="stylesheet" href="{{asset('assets/css/portal.css')}}">
    <link id="theme-style" rel="stylesheet" href="{{asset('assets/css/portal1.css')}}">
    <link id="theme-style" rel="stylesheet" href="{{asset('assets/css/styles.css')}}">
    <link href="{{ asset('assets/css/responsive.css') }}" rel="stylesheet">

   
</head> 

<body class="app">   	
    <header class="app-header fixed-top">	   	            

	@include('layoutss.topbar')
       @include('layoutss.sidebar')
    </header><!--//app-header-->
    
    <div class="app-wrapper">
	    
	    <div class="app-content pt-3 p-md-3 p-lg-4">
		    <div class="container-xl">
                
				@yield('content')
			    
			   @stack('modals')

			  
		    </div><!--//container-fluid-->
	    </div><!--//app-content-->
	    
	   
	    
    </div><!--//app-wrapper-->    					

 
    <!-- Javascript -->        
    <script src=" {{asset('assets/plugins/popper.min.js')}} "></script>
    <script src="{{asset('assets/plugins/bootstrap/js/bootstrap.min.js ')}}  "></script>  
   
   
    <!-- Charts JS -->
    <script src="{{asset('assets/plugins/chart.js/chart.min.js ')}}  "></script> 
    <script src=" {{asset('assets/js/charts-demo.js')}}  "></script> 
    
    <!-- Page Specific JS -->
    <script src=" {{asset('assets/js/app.js')}}  "></script> 
    <script src=" {{asset('assets/js/closedate.js')}}  "></script> 
@stack('scripts')
@stack('styles')
</body>
</html> 


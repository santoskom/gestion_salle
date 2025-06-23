

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Connexion</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{asset('css/auth.css')}}">
 
</head>
<body>
  
  <div class="container">
    
    <div class="left-section">
  <img src="{{ asset('assets/images/ble.jpeg') }}" alt="blé" />
  <h2>Transformez la nature, nourrissez l'avenir</h2>
  <p>Depuis le cœur des champs, nous sélectionnons les meilleurs grains de blé pour produire une farine
     d’exception. Découvrez notre engagement pour une alimentation saine, durable et respectueuse des
      traditions boulangères.</p>
</div>
    <div class="right-section">
      <div class="login-options">
        <img  src="{{ asset('assets/images/colombre.png') }}" alt="colombre">
        <img src="{{ asset('assets/images/pelicam.png') }}" alt="pilicam">
        <img src="{{ asset('assets/images/amigo.png') }}"alt="Amigo">
        <img src="{{ asset('assets/images/la camerounais.jpeg')}}" alt="LinkedIn">
      </div>
     

          @if(Session::get('error_msg'))
          <div class="alert alert-custom alert-dismissible fade show" role="alert">
              <div class="alert-content">
                  <i class="fas fa-exclamation-circle alert-icon"></i>
                  <div class="alert-text">
                      <strong class="alert-title">Erreur</strong>
                      <p class="alert-message">{{ Session::get('error_msg') }}</p>
                  </div>
              </div>
              {{-- <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> --}}
          </div>
          @endif

 <form method="post" action="{{route('handleLogin')}}">

      @csrf
      @method('POST')
        <hr style="margin-bottom: 20px;">
        <div class="input-group">
          <input type="email" name="email"  placeholder="Messagerie électronique" autocomplete="off">
        </div>
        <div class="input-group">
          <input type="password" name="password" placeholder="mot de passe " autocomplete="off">
        </div>
        <div class="checkbox-group">
          {{-- <label><input type="checkbox"> Restez connecté</label> --}}
          <a href="{{ route('password.request') }}">Mot de passe oublié ?</a>
        </div>
        <button type="submit">S’identifier</button>
        </form>
       
      </div>
    </div>
</body>
</html>

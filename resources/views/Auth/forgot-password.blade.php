<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mot de passe oublié</title>
    <link rel="stylesheet" href="{{asset('assets/css/resetpass.css')  }}">
    
</head>
<body>

    <div class="container">
        <h2>Mot de passe oublié</h2>
        <p>Entrez votre adresse e-mail pour recevoir un lien de réinitialisation.</p>

        @if(session('status'))
            <p style="color: rgb(9, 13, 11);">{{ session('status') }}</p>
        @endif

        <form method="POST" action="{{ route('password.email') }}">
            @csrf
           
            <input type="email" name="email" id="email" placeholder="Entrez votre adresse e-mail" required>

            <button type="submit">🔒 Réinitialiser le mot de passe</button>
        </form>

        <a href="{{ route('login') }}" class="back-link">Retour à la page de connexion</a>
    </div>
</body>
</html>

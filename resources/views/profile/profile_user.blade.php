

<div id="profileModal" class="modal-profile">
    <div class="modal-content">
        <span class="close" onclick="closeProfileModal()">❌</span>
        <h3>Profil de l'utilisateur</h3>
        <div class="profile-info">
            <img src="https://ui-avatars.com/api/?name={{ urlencode(Auth::user()->name) }}&background=4CAF50&color=fff" alt="Avatar" width="80">
            <p><strong>Nom :</strong> {{ Auth::user()->name }}</p>
            <p><strong>Email :</strong> {{ Auth::user()->email }}</p>
            <p><strong>Département :</strong> {{ Auth::user()->departement->nom ?? '—' }}</p>
            <p><strong>Rôle :</strong> {{ Auth::user()->roles->nom ?? '—' }}</p>
            <p><strong>Entreprise :</strong> {{ Auth::user()->company->name ?? Auth::user()->departement->company->name ?? '—' }}</p>
        </div>
    </div>
</div>
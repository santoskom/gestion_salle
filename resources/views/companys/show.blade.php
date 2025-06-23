@extends('layoutss.template')
@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>Détails de l'entreprise</h4>
                    <div>
                        <a href="{{ route('companys.edit', $company->id) }}" class="btn app-btn-primary">Modifier</a>
                        <a href="{{ route('companys.index') }}" class="btn btn-secondary">Retour</a>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            @if ($company->logo)
                                <img src="{{ asset('storage/' . $company->logo) }}" alt="{{ $company->name }}" class="img-fluid">
                            @else
                                <div class="alert alert-info">Pas de logo</div>
                            @endif
                        </div>
                        <div class="col-md-8">
                            <h3>{{ $company->name }}</h3>
                            <p><strong>Email:</strong> {{ $company->email ?? 'Non renseigné' }}</p>
                            <p><strong>Téléphone:</strong> {{ $company->phone ?? 'Non renseigné' }}</p>
                            <p><strong>Adresse:</strong> {{ $company->address ?? 'Non renseignée' }}</p>
                            
                        </div>
                    </div>
{{-- 
                 ici on va mettre les autre detaille    --}}
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@extends('layoutss.template')

@section('content')

<div class="row g-3 mb-4 align-items-center justify-content-between">
    <div class="col-auto">
        <h1 class="app-page-title mb-0">Entreprises</h1>
    </div>
    <div class="col-auto">
        <div class="page-utilities">
            <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
                <div class="col-auto">
                   
                </div><!--//col-->

                <div class="col-auto">
                    <a class="btn app-btn-secondary" href="{{ route('companys.create') }}">
                        Ajouter une entreprise
                    </a>
                </div>
            </div><!--//row-->
        </div><!--//page-utilities-->
    </div>
</div><!--//row-->

<div class="tab-content" id="company-table-tab-content">
    <div class="tab-pane fade show active" id="companies-all" role="tabpanel">
        <div class="app-card app-card-orders-table shadow-sm mb-5">
            <div class="app-card-body">
                @if (session('success'))
                    <div class="alert alert-success">{{ session('success') }}</div>
                @endif
                @if (session('error'))
                    <div class="alert alert-danger">{{ session('error') }}</div>
                @endif

                <div class="table-responsive table-wrapper">
                    <table class="table app-table-hover mb-0 text-left table-wrapper1">
                        <thead>
                            <tr>
                                <th class="cell">ID</th>
                                <th class="cell">Logo</th>
                                <th class="cell">Nom</th>
                                <th class="cell">Email</th>
                                <th class="cell">Téléphone</th>
                                <th class="cell">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($companys as $company)
                            <tr>
                                <td class="cell">{{ $company->id }}</td>
                                <td class="cell">
                                    @if ($company->logo)
                                        <img src="{{ asset('storage/' . $company->logo) }}" alt="{{ $company->name }}" width="40">
                                    @else
                                        <span>Pas de logo</span>
                                    @endif
                                </td>
                                <td class="cell">{{ $company->name }}</td>
                                <td class="cell">{{ $company->email }}</td>
                                <td class="cell">{{ $company->phone }}</td>
                                <td class="cell">
                                    <a class="btn btn-sm btn-info text-white" href="{{ route('companys.show', $company->id) }}">
                                        Voir
                                    </a>
                                    <a class="btn btn-sm btn-warning text-white" href="{{ route('companys.edit', $company->id) }}">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                            <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168z"/>
                                            <path d="M11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207z"/>
                                            <path d="M1.5 13.5V16h2.5l9.793-9.793-2.5-2.5L1.5 13.5z"/>
                                        </svg>
                                    </a>
                                    <form action="{{ route('companys.destroy', $company->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Êtes-vous sûr ?');">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                                <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1z"/>
                                                <path d="M3 5.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 .5.5v.5H3v-.5z"/>
                                            </svg>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            @empty
                            <tr>
                                <td class="cell" colspan="6">Aucune entreprise ajoutée</td>
                            </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div><!--//table-responsive-->
            </div><!--//app-card-body-->
        </div><!--//app-card-->
        <nav class="app-pagination">
            {{ $companys->links() }}
        </nav><!--//app-pagination-->
    </div><!--//tab-pane-->
</div><!--//tab-content-->

@endsection

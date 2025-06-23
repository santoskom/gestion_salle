 <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5>Départements</h5>
                                    <a href="{{ route('departements.create', ['company_id' => $company->id]) }}" class="btn btn-sm btn-primary">Ajouter</a>
                                </div>
                                <div class="card-body">
                                    @if($company->departments->count() > 0)
                                        <ul class="list-group">
                                            @foreach($company->departments as $department)
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    {{ $department->name }}
                                                    {{-- <div>
                                                        <a href="{{ route('departements.show', $department->id) }}" class="btn btn-sm btn-info">Voir</a>
                                                    </div> --}}
                                                </li>
                                            @endforeach
                                        </ul>
                                    @else
                                        <div class="alert alert-info">Aucun département</div>
                                    @endif
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5>Salles</h5>
                                    <a href="{{ route('salles.create', ['company_id' => $company->id]) }}" class="btn btn-sm btn-primary">Ajouter</a>
                                </div>
                                <div class="card-body">
                                    @if($company->salles->count() > 0)
                                        <ul class="list-group">
                                            @foreach($company->salles as $room)
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    {{ $room->name }}
                                                    {{-- <div>
                                                        <a href="{{ route('salles.show', $room->id) }}" class="btn btn-sm btn-info">Voir</a>
                                                    </div> --}}
                                                </li>
                                            @endforeach
                                        </ul>
                                    @else
                                        <div class="alert alert-info">Aucune salle</div>
                                    @endif
                                </div>
                            </div>
                        </div>
                    </div>
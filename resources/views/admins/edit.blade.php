@extends('layoutss.template')

@section('content')
    <h1 class="app-page-title">MODIFIER UN UTILISATEUR</h1>
    <hr class="mb-4">
    <div class="row g-4 settings-section">

        <div class="col-12 col-md-8">
            <div class="app-card app-card-settings shadow-sm p-4">

                <div class="app-card-body">
                    <form class="settings-form" method="post" action="{{ route('admins.update', $user->id) }}">

                        @csrf

                        @method('PUT')

                        <!-- Nom -->
                        <div class="mb-3">
                            <label for="setting-input-name" class="form-label">Nom</label>
                            <input type="text" class="form-control" id="setting-input-name" name="name"
                                value="{{ old('name', $user->name ?? '') }}" placeholder="Entrer le nom complet" required>
                            @error('name')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mb-3">
                            <label for="setting-input-email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="setting-input-email" name="email"
                                value="{{ old('email', $user->email ?? '') }}" placeholder="Entrer l'adresse email"
                                required>
                            @error('email')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mb-3">
                            <label for="setting-input-password" class="form-label">Mot de passe</label>
                            <input type="password" class="form-control" id="setting-input-password" name="password"
                                placeholder="Laisser vide pour ne pas changer" {{ isset($user) ? '' : 'required' }}>
                            @error('password')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>


                        <div class="mb-3">
                            <label for="setting-input-company" class="form-label">entreprise</label>
                            <label for="company_id" class="form-label">Entreprise</label>
                            <select name="company_id" id="company_id"
                                class="form-select @error('company_id') is-invalid @enderror">
                                <option value="">Sélectionner une entreprise</option>
                                @foreach ($companys as $company)
                                    <option value="{{ $company->id }}" @if (old('company_id', isset($user) ? $user->company_id : null) == $company->id) selected @endif>
                                        {{ $company->name }}
                                    </option>
                                @endforeach
                            </select>
                            @error('company_id')
                                <div class="invalid-feedback">
                                    {{ $message }}
                                </div>
                            @enderror
                        </div>

                        <div class="mb-3">
                            <label for="setting-input-departement" class="form-label">Département</label>
                            <select class="form-select" id="setting-input-departement" name="departement_id">
                                <option value="">Sélectionner un département</option>
                                @foreach ($departements as $departement)
                                    <option value="{{ $departement->id }}"
                                        {{ old('departement_id', $user->departement_id ?? '') == $departement->id ? 'selected' : '' }}>
                                        {{ $departement->nom }}
                                    </option>
                                @endforeach
                            </select>
                            @error('departement_id')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mb-3">
                            <label for="setting-input-role" class="form-label">Rôle</label>
                            <select class="form-select" id="setting-input-role" name="id_role" required>
                                <option value="">Sélectionner un rôle</option>
                                @foreach ($roles as $role)
                                    <option value="{{ $role->id }}"
                                        {{ old('id_role', $user->id_role ?? '') == $role->id ? 'selected' : '' }}>
                                        {{ $role->nom }}
                                    </option>
                                @endforeach
                            </select>
                            @error('id_role')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                        {{-- dans la version suivante la gestion des permissions sera inclu  --}}

                        {{-- <div class="mb-4">
																		<label class="form-label">Permissions</label>
																		<div class="row">
																			@foreach ($permissions as $permission)
																				@php
																					$isChecked = $user->permissions->contains('id', $permission->id);
																				@endphp
																				<div class="col-md-4 mb-2">
																					<div class="form-check">
																						<input class="form-check-input" type="checkbox" name="id_permissions[]"
																							   value="{{ $permission->id }}" id="permission{{ $permission->id }}"
																							   {{ $isChecked ? 'checked' : '' }}>
																						<label class="form-check-label" for="permission{{ $permission->id }}">
																							{{ $permission->nom }}
																						</label>
																					</div>
																				</div>
																			@endforeach
																		</div>
																		@error('id_permissions')
																			<div class="text-danger">
																				{{$message}}
																			</div>
																		@enderror
																	</div> --}}

                        <div class="mb-3">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="setting-input-notifications"
                                    name="receive_notifications" value="1"
                                    {{ old('receive_notifications', $user->receive_notifications ?? true) ? 'checked' : '' }}>
                                <label class="form-check-label" for="setting-input-notifications">Recevoir les
                                    notifications</label>
                            </div>
                            @error('receive_notifications')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <button type="submit" class="btn app-btn-primary">mise a jour</button>
                    </form>
                </div><!--//app-card-body-->

            </div><!--//app-card-->
        </div>
    </div><!--//row-->

    @push('scripts')
        <script src="{{ asset('assets/js/actualisation.js') }}"></script>
        <script src="{{ asset('assets/js/closedate.js') }}"></script>
        <script src="{{ asset('assets/js/reservation-validator.js') }}"></script>
        {{-- <script src="{{ asset('assets/js/conflit.js') }}"></script> --}}
    @endpush
@endsection

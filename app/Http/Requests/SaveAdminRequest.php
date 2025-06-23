<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SaveAdminRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, 
     */
    public function rules(): array
    {
        $user = $this->route('user');

        $userId = $user ? $user->id : null;

        $rules = [
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'departement_id' => 'nullable|exists:departements,id',
            'id_role' => 'required|exists:roles,id',
            'receive_notifications' => 'boolean',
            'company_id' => [
                'required',
                'exists:company,id',
            ],
        ];


        if ($this->isMethod('post')) {
            $rules['id_permissions'] = 'nullable|array';
            $rules['id_permissions.*'] = 'exists:permissions,id';
        } else {
            $rules['id_permissions'] = 'nullable|array';
            $rules['id_permissions.*'] = 'exists:permissions,id';
        }

        if ($this->isMethod('put') || $this->isMethod('patch')) {

            $rules['email'] = 'required|email|max:255|unique:users,email,' . $this->user->id;


            $rules['password'] = 'nullable|string|min:6';
        } else {

            $rules['password'] = 'required|string|min:6';
        }

        return $rules;
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array
     */
    public function messages()
    {
        return [
            'name.required' => 'Le nom est obligatoire',
            'email.required' => 'L\'email est obligatoire',
            'email.email' => 'Veuillez entrer une adresse email valide',
            'email.unique' => 'Cette adresse email est déjà utilisée',
            'password.required' => 'Le mot de passe est obligatoire',
            'password.min' => 'Le mot de passe doit contenir au moins 8 caractères',
            'id_role.required' => 'Le rôle est obligatoire',
            'id_permissions.required' => 'Vous devez sélectionner au moins une permission',
            'id_permissions.*.exists' => 'Une des permissions sélectionnées n\'existe pas',

            'company_id.required' => 'Veuillez sélectionner une entreprise.',

        ];
    }
}

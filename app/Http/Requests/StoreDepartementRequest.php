<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreDepartementRequest extends FormRequest
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
    $departement = $this->route('departement');

    $departementId = $departement ? $departement->id : null;

    return [
        'nom' => [
            'required',
            'string',
            'max:255',
            Rule::unique('departements', 'nom')->ignore($departementId),
        ],
        'description' => 'nullable|string|max:255',
        'responsable' => 'nullable|string|max:255',
        'telephone' => 'nullable|integer',
        'localisation' => [
            'nullable',
            'string',
            'max:255',
            Rule::unique('departements', 'localisation')->ignore($departementId),
        ],
     
    ];

}

public function messages() 
{
    return [
        'nom.required' => 'Le nom du département est requis',
        'nom.unique' => 'Le nom du département existe déjà',
        'description.max' => 'La description ne peut pas dépasser 255 caractères',
        'responsable.max' => 'Le nom du responsable ne peut pas dépasser 255 caractères',
        'telephone.max' => 'Le numéro de téléphone ne peut pas dépasser 20 caractères',
        'localisation.max' => 'La localisation ne peut pas dépasser 255 caractères',
    ];
}
}

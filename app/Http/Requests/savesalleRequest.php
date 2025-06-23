<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class savesalleRequest extends FormRequest
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
        $salle= $this->route('salle');
        $salleId = $salle ? $salle->id :null;

      
            return [
                'nom' => [
    'required',
    'string',
    'max:255',
    Rule::unique('salles', 'nom')->ignore($salleId),
],
    'localisation' => [
    'nullable',
    'string',
    'max:255',
    Rule::unique('salles', 'localisation')->ignore($salleId),
], 

                'capacite' => 'nullable|integer|min:1',
                'description' => 'nullable|string',
                
            ];

    }

    public function message(): array
{
    return [
        'nom.required' => 'Le nom de la salle est obligatoire.',
        'nom.unique' => 'Ce nom de salle est déjà utilisé. Veuillez en choisir un autre.',
        'nom.max' => 'Le nom de la salle ne doit pas dépasser 255 caractères.',

        'localisation.max' => 'La localisation ne doit pas dépasser 255 caractères.',

        'capacite.integer' => 'La capacité doit être un nombre entier.',
        'capacite.min' => 'La capacité doit être au minimum de 1.',

        'description.string' => 'La description doit être une chaîne de caractères.',
        
    ];
}

public function prepareForValidation()
{
    if (auth()->check()) {
        $this->merge([
            'company_id' => auth()->user()->company_id,
        ]);
    }
}

}

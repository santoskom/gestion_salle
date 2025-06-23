<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SaveEquipementRequest extends FormRequest
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
        $equipement = $this->route('equipement'); 
    $equipementId = $equipement ? $equipement->id : null;

    return [
        'nom' => [
            'required', 'string', 'max:255',
            Rule::unique('equipements', 'nom')->ignore($equipement?->id),
        ],
        'numero_serie' => [
            'required', 'string', 'max:255',
            Rule::unique('equipements', 'numero_serie')->ignore($equipement?->id),
        ],
        'description' => 'nullable|string|max:200',
        'marque' => 'required|string|max:255',
        'modele' => 'required|string|max:255',
    ];
    }
    
    public function messages()
{
    return [
        'nom.required' => 'Le nom de l\'équipement est obligatoire.',
        
        'nom.max' => 'Le nom ne doit pas dépasser 255 caractères.',

        'description.string' => 'La description doit être une chaîne de caractères.',
        'description.max' => 'La description ne doit pas dépasser 1000 caractères.',

        'numero_serie.required' => 'Le numéro de série est obligatoire.',
        'numero_serie.unique' => 'Ce numéro de série est déjà attribué à un autre équipement.',
        'numero_serie.max' => 'Le numéro de série ne doit pas dépasser 255 caractères.',

        'marque.string' => 'La marque doit être une chaîne de caractères.',
        'marque.max' => 'La marque ne doit pas dépasser 255 caractères.',

        'modele.required' => 'Le modèle est obligatoire.',
        'modele.string' => 'Le modèle doit être une chaîne de caractères.',
        'modele.max' => 'Le modèle ne doit pas dépasser 255 caractères.',
    ];
}

}



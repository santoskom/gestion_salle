<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SaveReservationRequests extends FormRequest
{
   /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
       
        return auth()->check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, 
     */
    public function rules(): array
    {
        return [
            'salle_id' => ['required', 'exists:salles,id'],
            'objet_reunion' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'date_debut' => ['required', 'date', 'after_or_equal:today'],
            'date_fin' => ['required', 'date', 'after_or_equal:date_debut'],
            'nombreParticipants' => ['required', 'integer', 'min:1'],
            'equipements' => ['nullable', 'array'],
            'equipements.*' => ['exists:equipements,id'],
            'rappel_active' => ['boolean'],
        ];
        
    }

    /**
     * Get custom attributes for validator errors.
     *
     * @return array<string, string>
     */
    public function attributes(): array
    {
        return [
            'salle_id' => 'salle',
            'objet_reunion' => 'objet de la réunion',
            'date_debut' => 'date de début',
            'date_fin' => 'date de fin',
            'nombreParticipants' => 'nombre de participants',
            'equipements' => ['nullable', 'array'],
            'equipements.*' => ['exists:equipements,id'],
            'rappel_active' => 'rappel automatique',
        ];
    }

    /**
     * Get the error messages for the defined validation rules.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'date_debut.after_or_equal' => 'La date de début doit être aujourd\'hui ou une date ultérieure.',
            'date_fin.after_or_equal' => 'La date de fin doit être égale ou postérieure à la date de début.',
        ];
    }
}
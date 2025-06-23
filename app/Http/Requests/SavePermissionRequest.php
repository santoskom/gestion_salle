<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SavePermissionRequest extends FormRequest
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
        
        $permission = $this->route('permission');

        return [
            'nom' => [
                'required',
                Rule::unique('permissions', 'nom')->ignore($permission?->id),
            ],
        ];
    }

    public function message() 
    {
        return[
            'nom.required'=>'le nom de  de la permission  est requis ',
       'nom.unique'=> 'le nom  existe deja  '
       ];

}
}

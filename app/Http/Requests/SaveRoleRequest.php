<?php

namespace App\Http\Requests;


use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SaveRoleRequest extends FormRequest
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
        $role = $this->route('role');
        $roleId = $role ? $role->id : null;

        return [
            'nom' => [
                'required',
                'string',
                'max:25',
                Rule::unique('roles','nom')->ignore($roleId),
                
            ],
        ];
   }
   public function message() 
        {
            return[
                 'nom.required'=>'le nom de  du role  est requis ',
            'nom.unique'=> 'le nom du role existe deja  '
            ];

    }
}

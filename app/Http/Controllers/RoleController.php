<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveRoleRequest;
use App\Models\Role;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    public function index(){
        $roles =Role::paginate(10);
 
        return view('roles.index',compact("roles"));
     }
 
     public function create(){
         return view('roles.create');
     }
 
     public function edit(Role $roles){
         return view('roles.edit', compact('roles'));
     }
 
     //action interaction 
 
 
 
     public function store( Role $role , SaveRoleRequest  $request){
         //enregistrer une role 
 
         try {
            //  $role->nom = $request->name;
           role::create($request->validated());
            
 
             return redirect()->route('roles.index')->with('succes_message', 'role enregistré avec succes');
              
         } catch (\Throwable $th) {
             dd($th);
         }
     }
 
     public function update( Role $role , SaveRoleRequest  $request){
         //enregistrer une role 
 
         try {
            
 
            $role->update($request->validated());
 
             return redirect()->route('roles.index')->with('succes_message', 'role mise a jour ');
              
         } catch (\Throwable $th) {
             dd($th);
         }

     }

     public function delete(Role $role)
     {
         try {
             $role->delete();
             return redirect()->route('roles.index')->with('success', 'role supprimée avec succès');
         } catch (\Throwable $th) {
             dd($th); // utile temporairement pour debug
         }
     }
 }
 
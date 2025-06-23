<?php

namespace App\Http\Controllers;

use App\Http\Requests\SavePermissionRequest;
use App\Models\Permission;
use Illuminate\Http\Request;

class PermissionController extends Controller
{
    public function index(){
        $permissions =Permission::paginate(10);
 
        return view('permissions.index',compact("permissions"));
     }
 
     public function create(){
         return view('permissions.create');
     }
 
     public function edit(Permission $permissions){
         return view('permissions.edit', compact('permissions'));
     }
 
 
 
 
 
     public function store( Permission $permission , SavePermissionRequest  $request){
         
 
      
         try {  
            
           Permission::create($request->validated());
            
 
             return redirect()->route('permissions.index')->with('succes_message', 'permission enregistré avec succes');
              
         } catch (\Throwable $th) {
             dd($th);
         }
     }
 
     public function update( Permission $permission , SavePermissionRequest  $request){
          
 
         try {
          
            $permission->update($request->validated());
 
             return redirect()->route('permissions.index')->with('succes_message', 'permission mise a jour ');
              
         } catch (\Throwable $th) {
             dd($th);
         }

     }

     public function delete(Permission $permission)
     {
         try {
             $permission->delete();
             return redirect()->route('permissions.index')->with('success', 'permission supprimée avec succès');
         } catch (\Throwable $th) {
             dd($th); 
            
            }
     }
 }
 
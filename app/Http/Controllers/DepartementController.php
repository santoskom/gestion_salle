<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreDepartementRequest;
use App\Models\Departement;
use Illuminate\Http\Request;

class DepartementController extends Controller
{
    public function index(){
        $departements =Departement::paginate(10);
        
        return view('departements.index',compact('departements'));
     }
 
     public function create(){
       
         return view('departements.create');
     }
 
     public function edit(Departement $departement){
       
         return view('departements.edit',compact('departement'));
     }
 
     
 
 
 
     public function store(StoreDepartementRequest $request)
{
    try {
      
        $validatedData = $request->validated();
        
       
        $validatedData['company_id'] = auth()->user()->company_id;
        
       
        Departement::create($validatedData);
        
        return redirect()->route('departements.index')
            ->with('succes_message', 'Département enregistré avec succès');
    } catch (\Throwable $th) {
      
        dd($th);
    }
}
 
public function update(Departement $departement, StoreDepartementRequest $request)
{
    try {
       
        $validatedData = $request->validated();
        
      
        $validatedData['company_id'] = auth()->user()->company_id;
        
       
        $departement->update($validatedData);
        
        return redirect()
            ->route('departements.index')
            ->with('succes_message', 'Département mis à jour avec succès.');
        
    } catch (\Throwable $th) {
      
        dd($th);
    }
}

     public function delete(Departement $departement)
     {
         try {
             $departement->delete();
             return redirect()->route('departements.index')->with('success', 'departement supprimée avec succès');
         } catch (\Throwable $th) {
             dd($th); 
         }
     }
    
    

}

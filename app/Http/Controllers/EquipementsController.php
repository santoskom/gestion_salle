<?php

namespace App\Http\Controllers;

use App\Http\Requests\SaveEquipementRequest;
use App\Models\Equipement;
use Illuminate\Http\Request;

class EquipementsController extends Controller
{ /**
    * Afficher la liste des équipements
    */
   public function index()
   {
       $equipements =Equipement::paginate(10);
    

       return view('equipements.index', compact('equipements'));
   }

   /**
    * Afficher le formulaire de création d'un équipement
    */
   public function create()
   {
       return view('equipements.create');
   }

   /**
    * Enregistrer un nouvel équipement
    */
   public function store(SaveEquipementRequest $request ,  Equipement $equipement)
   {
       try { 
            $equipement->create($request->validated());

       return redirect()->route('equipements.index')
           ->with('success', 'Équipement ajouté avec succès');
           
       } catch (\Throwable $th) {
           dd($th);
       }
     
   }

   /**
    * Afficher le formulaire d'édition d'un équipement
    */
   public function edit(Equipement $equipement)
   {
       return view('equipements.edit', compact('equipement'));
   }

   /**
    * Mettre à jour un équipement
    */
   public function update(SaveEquipementRequest $request, Equipement $equipement)
   {
       try { 
           $equipement->update($request->validated());

           return redirect()->route('equipements.index')
           ->with('succes_message', 'Équipement mis à jour avec succès');
          
      } catch (\Throwable $th) {
          dd($th);
      }
    
   }

   

   public function destroy($id)
{
    $equipement = Equipement::findOrFail($id);
    

     if ($equipement->reservations()->exists()) {
        return redirect()->back()->with('error', 'Impossible de supprimer cet équipement car il est encore utilisé dans une ou plusieurs réservations.');
    }
    $equipement->delete();

    return redirect()->route('equipements.index')->with('success', 'Équipement supprimé avec succès.');
}
}

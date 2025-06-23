<?php

namespace App\Http\Controllers;


use App\Http\Requests\savesalleRequest;
use App\Models\company;
use App\Models\Salle;
use App\Traits\ChecksUserRole;
use Illuminate\Http\Request;

class SalleController extends Controller
{

    use ChecksUserRole;

    public function index()
    {
        

        $user = auth()->user();
        $salles = Salle::where('company_id', $user->company_id)->paginate(5);
        $totalSalle = Salle::where('company_id', $user->company_id)->count();
        
        $companys = company::all();
        
        return view('salles.index', compact('salles', 'totalSalle', 'companys'));
    }

    
     public function create()
    {
        

        if (!$this->isAssistantDirecteur() && !$this->isAdmin()) {
            abort(403, "Vous n'avez pas l'autorisation d'accéder à cette ressource.");
        }
        
        $companys = company::all();
        return view('salles.create', compact('companys'));
    }
 
    public function edit(Salle $salle)
    {
        

        if (!$this->isAssistantDirecteur() && !$this->isAdmin()) {
            abort(403, "Vous n'avez pas l'autorisation d'accéder à cette ressource.");
        }
        
        

        if (auth()->user()->company_id !== $salle->company_id) {
            abort(403, "Vous n'avez pas accès à cette salle.");
        }
        
        $companys = company::all();
        return view('salles.edit', compact('salle', 'companys'));
    }
 

    /**
     * Store a newly created resource in storage.
     */
    public function store(SaveSalleRequest $request)
    {
        

        if (!$this->isAssistantDirecteur() && !$this->isAdmin()) {
            abort(403, "Vous n'avez pas l'autorisation d'accéder à cette ressource.");
        }
        
        try {
            $data = $request->validated();
            
            

            $data['company_id'] = auth()->user()->company_id;
            
            Salle::create($data);
            
            return redirect()->route('salles.index')
                ->with('succes_message', 'Salle enregistrée avec succès.');
        } catch (\Throwable $th) {
            dd($th);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Salle $salle)
    {
        

        if (auth()->user()->company_id !== $salle->company_id) {
            abort(403, "Vous n'avez pas accès à cette salle.");
        }
        
        return view('salles.show', compact('salle'));
    }

  
    public function update(SaveSalleRequest $request, Salle $salle)
    {
        

        if (!$this->isAssistantDirecteur() && !$this->isAdmin()) {
            abort(403, "Vous n'avez pas l'autorisation d'accéder à cette ressource.");
        }
        
        try {
            

            if (auth()->user()->company_id !== $salle->company_id) {
                abort(403, "Vous n'avez pas accès à cette salle.");
            }
            
            $data = $request->validated();
            
            

            $data['company_id'] = auth()->user()->company_id;
            
            $salle->update($data);
            
            return redirect()->route('salles.index')
                ->with('succes_message', 'Salle mise à jour avec succès.');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
    

    /**
     * Remove the specified resource from storage.
     */
    public function delete(Salle $salle)
    {
        

        if (!$this->isAssistantDirecteur() && !$this->isAdmin()) {
            abort(403, "Vous n'avez pas l'autorisation d'accéder à cette ressource.");
        }
        
        try {
            

            if (auth()->user()->company_id !== $salle->company_id) {
                abort(403, "Vous n'avez pas accès à cette salle.");
            }
            
            $salle->delete();
            return redirect()->route('salles.index')
                ->with('succes_message', 'Salle supprimée avec succès');
        } catch (\Throwable $th) {
            dd($th);
        }
    }
}


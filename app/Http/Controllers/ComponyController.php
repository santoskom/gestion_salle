<?php

namespace App\Http\Controllers;

use App\Models\company;
use App\Models\Departement;
use App\Models\Salle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ComponyController extends Controller
{

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $companys = company::paginate();
        return view('companys.index', compact('companys'));
    }

    /**
     * Show the form for creating a new resource.
     */
    
    public function create()
    {
        return view('companys.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
            'logo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            
        ]);

        if ($request->hasFile('logo')) {
            $logoPath = $request->file('logo')->store('companys', 'public');
            $validatedData['logo'] = $logoPath;
        }

        company::create($validatedData);

        return redirect()->route('companys.index')
            ->with('success', 'Entreprise créée avec succès.');
    }

    /**
     * Display the specified resource.
     */
    public function show(company $company)
    {
        return view('companys.show', compact('company'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(company $company)
    {
        return view('companys.edit', compact('company'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, company $company)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
            'logo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
           
        ]);

        if ($request->hasFile('logo')) {
           
            if ($company->logo) {
                Storage::disk('public')->delete($company->logo);
            }
            
            $logoPath = $request->file('logo')->store('companys', 'public');
            $validatedData['logo'] = $logoPath;
        }

        $company->update($validatedData);

        return redirect()->route('companys.index')
            ->with('success', 'Entreprise mise à jour avec succès.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(company $company)
    {
        
        if ($company->departments()->count() > 0) {
            return redirect()->route('companys.index')
                ->with('error', 'Impossible de supprimer cette entreprise car elle possède des départements.');
        }

       
        if ($company->salles()->count() > 0) {
            return redirect()->route('companys.index')
                ->with('error', 'Impossible de supprimer cette entreprise car elle possède des salles.');
        }

       
        if ($company->logo) {
            Storage::disk('public')->delete($company->logo);
        }

        $company->delete();

        return redirect()->route('companys.index')
            ->with('success', 'Entreprise supprimée avec succès.');
    }
}
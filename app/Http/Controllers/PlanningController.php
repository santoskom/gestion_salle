<?php

namespace App\Http\Controllers;

use App\Models\Reservations;

use App\Models\Salle;
use App\Models\Departement;
use Illuminate\Http\Request;
use PDF;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use App\Mail\PlanningMail;
class PlanningController extends Controller
{
 
public function index(Request $request)
{
    $user = auth()->user();
    $isAssistant = $user->hasRole('Assistant de directions');
    $userCompanyId = $user->company_id;
    
   
    $salles = Salle::where('company_id', $userCompanyId)->get();
    $departements = Departement::where('company_id', $userCompanyId)->get();
    
    
    $week = $request->input('week', 0); 
    $weekOffset = (int)$week;
    
    
    $startDate = Carbon::now()->startOfWeek()->addWeeks($weekOffset);
    $endDate = Carbon::now()->endOfWeek()->addWeeks($weekOffset);
    
   
    $filters = [
        'salle_id' => $request->input('salle_id'),
        'departement_id' => $request->input('departement_id'),
        'date_debut' => $request->input('date_debut', $startDate->format('Y-m-d')),
        'date_fin' => $request->input('date_fin', $endDate->format('Y-m-d')),
        'week' => $weekOffset
    ];
    

    $reservationsQuery = Reservations::with(['salle', 'demandeur'])
        ->whereBetween('date_debut', [$filters['date_debut'], $filters['date_fin']])
        ->whereHas('salle', function($query) use ($userCompanyId) {
            $query->where('company_id', $userCompanyId);
        })
        ->where('statut', 'valide')
        ->orderBy('date_debut');
    
   
    if ($filters['salle_id']) {
        $reservationsQuery->where('salle_id', $filters['salle_id']);
    }
    
   
    if ($filters['departement_id']) {
        $reservationsQuery->whereHas('demandeur', function($query) use ($filters) {
            $query->where('departement_id', $filters['departement_id']);
        });
    }
    
    
    if (!$isAssistant) {
        $reservationsQuery->where('id_demandeur', $user->id); 
    }
    
   
    $allReservations = $reservationsQuery->get();
    

    $planningData = [];
    $currentDate = Carbon::parse($filters['date_debut']);
    $endDateLoop = Carbon::parse($filters['date_fin']);
    
    while ($currentDate->lte($endDateLoop)) {
        
        if ($currentDate->dayOfWeek !== Carbon::SUNDAY) {
            $dateStr = $currentDate->format('Y-m-d');
            $dayReservations = $allReservations->filter(function($res) use ($currentDate) {
                return Carbon::parse($res->date_debut)->isSameDay($currentDate);
            });
            
            
            if ($dayReservations->count() > 0) {
                $planningData[$dateStr] = [
                    'jour' => $currentDate->translatedFormat('l'),
                    'date' => $currentDate->format('d/m/Y'),
                    'reservations' => $dayReservations
                ];
            }
        }
        
        $currentDate->addDay();
    }
    
    
    $navigation = [
        'currentWeek' => $weekOffset,
        'previousWeek' => $weekOffset - 1,
        'nextWeek' => $weekOffset + 1,
        'currentWeekStart' => $startDate->format('d/m/Y'),
        'currentWeekEnd' => $endDate->format('d/m/Y'),
    ];
    
    return view('planning.index', array_merge(
        compact('planningData', 'salles', 'departements', 'navigation'),
        $filters
    ));
}


   public function exportPdf(Request $request)
{
    $user = auth()->user();
    $userCompanyId = $user->company_id;

    
    $salles = Salle::where('company_id', $userCompanyId)->get();

    
    $departements = Departement::where('company_id', $userCompanyId)->get();

    $salle_id = $request->input('salle_id');
    $departement_id = $request->input('departement_id');
    $date_debut = $request->input('date_debut', Carbon::now()->startOfWeek()->format('Y-m-d'));
    $date_fin = $request->input('date_fin', Carbon::now()->endOfWeek()->format('Y-m-d'));

    $reservationsQuery = Reservations::with(['salle', 'demandeur'])
        ->where('statut', 'valide')
        ->whereBetween('date_debut', [$date_debut, $date_fin])
        ->whereHas('salle', function ($query) use ($userCompanyId) {
            $query->where('company_id', $userCompanyId);
        })
        ->orderBy('date_debut'); 

    if ($salle_id) {
        $reservationsQuery->where('salle_id', $salle_id);
    }

    if ($departement_id) {
        $reservationsQuery->whereHas('demandeur', function ($query) use ($departement_id) {
            $query->where('departement_id', $departement_id);
        });
    }

    $reservations = $reservationsQuery->get();

    $planningData = [];
    $currentDate = Carbon::parse($date_debut);
    $endDate = Carbon::parse($date_fin);

    while ($currentDate->lte($endDate)) {
        $dateStr = $currentDate->format('Y-m-d');
        $planningData[$dateStr] = [
            'jour' => $currentDate->translatedFormat('l'),
            'date' => $currentDate->format('d/m/Y'),
            'reservations' => $reservations->filter(function ($res) use ($dateStr) {
                return Carbon::parse($res->date_debut)->format('Y-m-d') === $dateStr;
            })->sortBy('date_debut') 
        ];
        $currentDate->addDay();
    }
    
    
    $pdf = PDF::loadView('planning.pdf', [
        'planningData' => $planningData,
        'date_debut' => Carbon::parse($date_debut)->format('d/m/Y'),
        'date_fin' => Carbon::parse($date_fin)->format('d/m/Y'),
        'salle' => $salle_id ? Salle::find($salle_id)->nom : 'Toutes',
        'departement' => $departement_id ? Departement::find($departement_id)->nom : 'Tous'
    ]);
    
    return $pdf->download('planning-reservation-salles.pdf');
}
    
    public function sendEmail(Request $request)
{
    $userCompanyId = auth()->user()->company_id;

    $request->validate([
        'email' => 'required|email',
        'date_debut' => 'required|date',
        'date_fin' => 'required|date',
    ]);

    $date_debut = $request->input('date_debut');
    $date_fin = $request->input('date_fin');
    $email = $request->input('email');
    $salle_id = $request->input('salle_id');
    $departement_id = $request->input('departement_id');

    $reservationsQuery = Reservations::with(['salle', 'demandeur'])
        ->where('statut', 'valide')
        ->whereBetween('date_debut', [$date_debut, $date_fin])
        ->whereHas('salle', function ($query) use ($userCompanyId) {
            $query->where('company_id', $userCompanyId);
        })
        ->orderBy('date_debut'); 

    if ($salle_id) {
        $reservationsQuery->where('salle_id', $salle_id);
    }

    if ($departement_id) {
        $reservationsQuery->whereHas('demandeur', function ($query) use ($departement_id) {
            $query->where('departement_id', $departement_id);
        });
    }

    $reservations = $reservationsQuery->get();
    
    
    $planningData = [];
    $currentDate = Carbon::parse($date_debut);
    $endDate = Carbon::parse($date_fin);
    
    while ($currentDate->lte($endDate)) {
        $dateStr = $currentDate->format('Y-m-d');
        $planningData[$dateStr] = [
            'jour' => $currentDate->translatedFormat('l'),
            'date' => $currentDate->format('d/m/Y'),
            'reservations' => $reservations->filter(function ($res) use ($dateStr) {
                return Carbon::parse($res->date_debut)->format('Y-m-d') === $dateStr;
            })->sortBy('date_debut') 
        ];
        
        $currentDate->addDay();
    }
    
    
    $pdf = PDF::loadView('planning.pdf', [
        'planningData' => $planningData,
        'date_debut' => Carbon::parse($date_debut)->format('d/m/Y'),
        'date_fin' => Carbon::parse($date_fin)->format('d/m/Y'),
        'salle' => $salle_id ? Salle::find($salle_id)->nom : 'Toutes',
        'departement' => $departement_id ? Departement::find($departement_id)->nom : 'Tous'
    ]);
    
    $emailData = [
        'date_debut' => Carbon::parse($date_debut)->format('d/m/Y'),
        'date_fin' => Carbon::parse($date_fin)->format('d/m/Y'),
        'planningData' => $planningData
    ];
    
    
    Mail::to($request->email)
        ->send(new PlanningMail($emailData, $pdf->output()));
    
    return redirect()->route('planning.index', [
            'salle_id' => $salle_id,
            'departement_id' => $departement_id,
            'date_debut' => $date_debut,
            'date_fin' => $date_fin
        ])
        ->with('success', 'Le planning a été envoyé à ' . $request->email);
}
}
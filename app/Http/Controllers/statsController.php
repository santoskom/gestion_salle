<?php

namespace App\Http\Controllers;

use App\Models\Company;
use App\Models\Reservations;
use App\Models\Salle;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class statsController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $isAssistantDirection = $user->role === 'Assistants de directions';
        $userCompanyId = $user->company_id;

        $reminders = $this->checkUpcomingReservations();

        // Initialiser refusedChartData à null par défaut
        $refusedChartData = null;

        if (!$isAssistantDirection) {
            $salleIds = Salle::where('company_id', $userCompanyId)->pluck('id')->toArray();

            $totalReservation = Reservations::whereIn('salle_id', $salleIds)->count();
            $totalsalle = Salle::where('company_id', $userCompanyId)->count();
            $totalReservationsEnAttente = Reservations::whereIn('salle_id', $salleIds)
                ->where('statut', 'en_attente')
                ->count();
            $totalAdministateur = User::where('company_id', $userCompanyId)->count();
            $companyName = Company::find($userCompanyId)->name ?? 'Votre entreprise';

            // Statistiques refusées pour l'entreprise courante
            $refusedReservations = Reservations::whereIn('salle_id', $salleIds)
                ->where('statut', 'refusee')
                ->count();
        } else {
            $totalReservation = Reservations::count();
            $totalsalle = Salle::count();
            $totalReservationsEnAttente = Reservations::where('statut', 'en_attente')->count();
            $totalAdministateur = User::count();
            $companyName = null;

            // Récupérer les réservations refusées par entreprise pour l'assistant de direction
            $refusedChartData = $this->getRefusedReservationsByCompany();
        }

        $percentageSalle = $this->calculatePercentage($totalsalle, $totalReservation);
        $percentageReservations = $this->calculatePercentage($totalReservation, $totalsalle);

        $currentDate = now();
        $startOfWeek = $currentDate->copy()->startOfWeek();

        $sallesQuery = DB::table('salles');

        if (!$isAssistantDirection) { // Correction: c'était inversé
            $sallesQuery->where('company_id', $userCompanyId);
        }

        $salles = $sallesQuery->pluck('nom', 'id');
        $salleIds = $salles->keys()->toArray();

        $reservations = Reservations::select(
            DB::raw('salle_id'),
            DB::raw('DATE(date_debut) as date'),
            DB::raw('COUNT(*) as total')
        )
            ->whereIn('salle_id', $salleIds)
            ->whereBetween(DB::raw('DATE(date_debut)'), [$startOfWeek, $startOfWeek->copy()->addDays(6)])
            ->groupBy('salle_id', 'date')
            ->orderBy('date')
            ->get();

        $groupedData = [];
        foreach ($salles as $id => $nom) {
            $groupedData[$nom] = array_fill(0, 7, 0);
        }

        foreach ($reservations as $res) {
            $nomSalle = $salles[$res->salle_id] ?? 'Inconnue';
            $dayIndex = Carbon::parse($res->date)->diffInDays($startOfWeek);
            if ($dayIndex >= 0 && $dayIndex < 7) {
                $groupedData[$nomSalle][$dayIndex] = $res->total;
            }
        }

        $datasets = [];
        foreach ($groupedData as $nom => $valeurs) {
            $datasets[] = [
                'label' => $nom,
                'data' => array_values($valeurs),
                'fill' => false,
                'borderColor' => sprintf('rgba(%d, %d, %d, 1)', rand(0, 255), rand(0, 255), rand(0, 255)),
                'tension' => 0.3,
            ];
        }

        return view('stats', [
            'reminders' => $reminders,
            'totalReservation' => $totalReservation,
            'totalsalle' => $totalsalle,
            'totalAdministateur' => $totalAdministateur,
            'totalReservationsEnAttente' => $totalReservationsEnAttente,
            'datasets' => $datasets,
            'percentageSalle' => $percentageSalle,
            'percentageReservations' => $percentageReservations,
            'isAssistantDirection' => $isAssistantDirection,
            'companyName' => $companyName,
            'refusedChartData' => $refusedChartData, // Toujours défini
        ]);
    }

    public function calculatePercentage($value, $total) 
    {
        if ($total == 0) {
            return 0; 
        }
        return round(($value / $total) * 100); 
    }

    /**
     * Récupère les réservations refusées groupées par entreprise
     */
    protected function getRefusedReservationsByCompany()
    {
        // Récupérer les entreprises avec leurs salles et réservations refusées
        $companies = Company::with(['salles.reservations' => function($query) {
            $query->where('statut', 'refuse');
        }])->get();

        $labels = [];
        $data = [];
        $backgroundColors = [];

        foreach ($companies as $company) {
            $refusedCount = 0;
            
            // Compter les réservations refusées pour cette entreprise
            foreach ($company->salles as $salle) {
                $refusedCount += $salle->reservations->count();
            }
            
            // Ajouter seulement si il y a des réservations refusées
            if ($refusedCount > 0) {
                $labels[] = $company->name;
                $data[] = $refusedCount;
                $backgroundColors[] = sprintf('rgba(%d, %d, %d, 0.7)', rand(0, 255), rand(0, 255), rand(0, 255));
            }
        }

        return [
            'labels' => $labels,
            'datasets' => [
                [
                    'label' => 'Réservations refusées',
                    'data' => $data,
                    'backgroundColor' => $backgroundColors,
                    'borderColor' => 'rgba(255, 99, 132, 1)',
                    'borderWidth' => 1
                ]
            ]
        ];
    }

    /**
     * Vérifie les réservations à venir pour les rappels
     */
    protected function checkUpcomingReservations()
    {
        $user = Auth::user();
        $isAssistantDirection = $user->role === 'Assistants de directions';
        $userCompanyId = $user->company_id;

        $now = Carbon::now();
        $threshold = Carbon::now()->addHours(2); // 2 heures avant la réunion

        $query = Reservations::with(['salle', 'user'])
            ->where('date_debut', '>=', $now)
            ->where('date_debut', '<=', $threshold)
            ->where('rappel_active', true)
            ->orderBy('date_debut');

        if (!$isAssistantDirection) {
            $salleIds = Salle::where('company_id', $userCompanyId)->pluck('id')->toArray();
            $query->whereIn('salle_id', $salleIds);
        }

        return $query->get()->map(function($reservation) use ($now) {
            return [
                'id' => $reservation->id,
                'salle' => $reservation->salle->nom,
                'date_debut' => $reservation->date_debut->format('d/m/Y H:i'),
                'objet' => $reservation->objet_reunion,
                'user' => $reservation->user->name,
                'time_left' => $reservation->date_debut->diffForHumans($now, true)
            ];
        });
    }
}
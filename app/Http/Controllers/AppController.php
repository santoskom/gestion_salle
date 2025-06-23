<?php

namespace App\Http\Controllers;

use App\Models\Company ;
use App\Models\Reservations;
use App\Models\Salle;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class AppController extends Controller
{
    public function index()
    {

        $user = Auth::user();
        $isAssistantDirection = $user->role === 'Assistants de directions';
        $userCompanyId = $user->company_id;

        $reminders = $this->checkUpcomingReservations();

        if (!$isAssistantDirection) {
            $salleIds = Salle::where('company_id', $userCompanyId)->pluck('id')->toArray();

            $totalReservation = Reservations::whereIn('salle_id', $salleIds)->count();
            $totalsalle = Salle::where('company_id', $userCompanyId)->count();
            $totalReservationsEnAttente = Reservations::whereIn('salle_id', $salleIds)
                ->where('statut', 'en_attente')
                ->count();
            $totalAdministateur = User::where('company_id', $userCompanyId)->count();

            $companyName = Company ::find($userCompanyId)->name ?? 'Votre entreprise';
        } else {
            $totalReservation = Reservations::count();
            $totalsalle = Salle::count();
            $totalReservationsEnAttente = Reservations::where('statut', 'en_attente')->count();

            $totalAdministateur = User::count();

            $companyName = null;
        }

        $percentageSalle = $this->calculatePercentage($totalsalle, $totalReservation);
        $percentageReservations = $this->calculatePercentage($totalReservation, $totalsalle);

        $currentDate = now();
        $startOfWeek = $currentDate->copy()->startOfWeek();

        $sallesQuery = DB::table('salles');

        if ($isAssistantDirection) {
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

        return view('dashbord', [
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
        ]);
    }

    public function calculatePercentage($value, $total)
    {
        if ($total == 0) {
            return 0;
        }
        return round(($value / $total) * 100);
    }


    public function checkUpcomingReservations()
    {
        $now = Carbon::now();
        $inThirtyMinutes = $now->copy()->addMinutes(30);
        $user = Auth::user();


        $query = Reservations::whereBetween('date_debut', [$now, $inThirtyMinutes]);

        if ($user->role === 'assistant_direction') {
            $salleIds = Salle::where('company_id', $user->company_id)->pluck('id')->toArray();
            $query->whereIn('salle_id', $salleIds);
        }

        return $query->with(['salle', 'salle.company', 'user'])->get();
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class NotificationApiController extends Controller
{
   /**
     * Affiche toutes les notifications de l'utilisateur
     */
    public function index()
    {
        $user = Auth::user();
        $notifications = $user->notifications;
        
        return view('notifications.index', compact('notifications'));
    }
    
    /**
     * Affiche le nombre de notifications non lues
     */
    public function getUnreadCount()
    {
        $user = Auth::user();
        $unreadCount = $user->unreadNotifications->count();
        
        return response()->json(['count' => $unreadCount]);
    }
    
    /**
     * Marque une notification comme lue
     */
    public function markAsRead($id)
    {
        $user = Auth::user();
        $notification = $user->notifications()->findOrFail($id);
        $notification->markAsRead();
        
        return redirect()->back()->with('success', 'Notification marquée comme lue');
    }
    
    /**
     * Marque toutes les notifications comme lues
     */
    public function markAllAsRead()
    {
        $user = Auth::user();
        $user->unreadNotifications->markAsRead();
        
        return redirect()->back()->with('success', 'Toutes les notifications ont été marquées comme lues');
    }
    
    /**
     * Supprime une notification
     */
    public function destroy($id)
    {
        $user = Auth::user();
        $notification = $user->notifications()->findOrFail($id);
        $notification->delete();
        
        return redirect()->back()->with('success', 'Notification supprimée');
    }
}
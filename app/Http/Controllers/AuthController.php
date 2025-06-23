<?php

namespace App\Http\Controllers;

use App\Http\Requests\AuthRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login()
    {
        return view('Auth.login');
    }

    public function handleLogin(AuthRequest $request){

     $credentials= $request ->only(['email','password']);

   if (Auth::attempt($credentials)) {

      return redirect()->route('dashbord');
   }else {
    return redirect()->back()->with('error_msg','parametre de connection non reconnu');
   }
    }
}

<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'AuthController@login');
Route::post('logout', 'AuthController@logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'AuthController@register');
Route::post('refresh', 'AuthController@refresh');
Route::get('me', 'AuthController@me');
Route::get('/home', 'HomeController@index')->name('home');

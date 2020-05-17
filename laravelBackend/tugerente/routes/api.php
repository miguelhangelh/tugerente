<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('login', 'AuthController@login');
Route::post('register', 'AuthController@register');

Route::group(['middleware' => 'auth.jwt'], function () {
    Route::post('logout', 'AuthController@logout');
    Route::post('adduser', 'groupsController@adduser');
    Route::get('getusers', 'AuthController@getusers');
    Route::get('getuser', 'AuthController@getuser');
    Route::resource('notes', 'notesController');
    Route::resource('groups', 'groupsController');
    // Route::get('tasks', 'TaskController@index');
    // Route::get('tasks/{id}', 'TaskController@show');
    // Route::post('tasks', 'TaskController@store');
    // Route::put('tasks/{id}', 'TaskController@update');
    // Route::delete('tasks/{id}', 'TaskController@destroy');
});

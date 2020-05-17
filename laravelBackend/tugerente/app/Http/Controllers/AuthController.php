<?php

namespace App\Http\Controllers;

use JWTAuth;
use App\User;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Exceptions\JWTException;
use App\Http\Requests\RegistrationFormRequest;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    /**
     * @var bool
     */
    public $loginAfterSignUp = true;

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request)
    {
        $credentials = request(['email', 'password']);

        if (!$token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60
        ]);
    }
    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function logout()
    {
        auth()->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }
    public function getusers()
    {
        $data = DB::table('users')->Leftjoin('groupsusers', 'users.id', 'groupsusers.usercode')->whereNull('groupsusers.usercode')->get();
        return response()->json(['message' => 'Successfully', 'data' => $data]);
    }
    public function getuser()
    {
        $data = auth()->user();
        return response()->json(['message' => 'Successfully', 'data' => $data]);
    }
    /**
     * @param RegistrationFormRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(RegistrationFormRequest $request)
    {
        $user = new User();
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = bcrypt($request->password);
        $user->save();


        return response()->json([
            'success'   =>  true,
            'data'      =>  $user
        ], 200);
    }
}

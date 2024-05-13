<?php
use App\Http\Controllers\CartController;
/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/cart/{user_id}', 'CartController@getAllCartItems');
$router->get('/cart/products/{product_id}', 'CartController@getProductQuantity');

$router->get('/', function () use ($router) {
    return $router->app->version();
});

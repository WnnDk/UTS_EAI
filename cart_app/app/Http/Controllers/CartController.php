<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Fascades\Response;

use Illuminate\Support\Facades\DB;

class CartController extends Controller
{
    // Method untuk mendapatkan semua item keranjang
    public function getAllCartItems($user_id)
    {
        $cartItems = DB::table('cart')->where('user_id', $user_id)->get();
        if ($cartItems->isEmpty()) {
            return response()->json(['message' => 'Cart is empty'], 404);
        }
        return response()->json($cartItems);
    }

    // Method untuk mendapatkan jumlah produk berdasarkan ID produk
    public function getProductQuantity($product_id)
    {
        $totalQuantity = DB::table('cart')->where('product_id', $product_id)->sum('quantity');
        if ($totalQuantity === null) {
            return response()->json(['message' => 'Product not found in any cart'], 404);
        }
        return response()->json(['product_id' => $product_id, 'total_quantity' => $totalQuantity]);
    }
}

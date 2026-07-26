import 'dart:developer';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';

class CartRepo {
  ApiServices apiServices = ApiServices();




  //----------getCartResponse-------------------
  Future<GetCartResponseModel> getCartData() async {
    try {
      final res = await apiServices.get('/cart');

      log("🔍 CART RESPONSE FULL: $res");

      return GetCartResponseModel.fromJson(res);
    } catch (e) {
      log("❌ CART ERROR: $e");
      throw ApiError(message: e.toString());
    }
  }

  ///------------ remove cart--------------
  Future<void> removeCartItem(int id) async {
    try {
      final res = await apiServices.delete('/cart/remove/$id' );
      log("🔍🔍🔍🔍🔍🔍🔍 CART remove : $res");
      if (res['code'] == 200 && res['data'] == null) {
        throw ApiError(message: 'Cart Deleted  Successfully');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //clear cart items

  Future<bool> clearCart() async {
    try {
      final response = await apiServices.delete('/cart/clear');

      return response['code'] == 200;
    } catch (e) {
      log("❌ CLEAR CART ERROR: $e");
      return false;
    }
  }
}



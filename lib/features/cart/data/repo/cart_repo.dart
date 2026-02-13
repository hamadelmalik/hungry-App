import 'dart:developer';
import 'dart:io';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/response_parser.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';

class CartRepo {
  ApiServices apiServices = ApiServices();
  //=========addToCart-------------------
  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      final res = await apiServices.post('/cart/add', cartData.toJson());

      log("🛒 ADD TO CART RAW RESPONSE: $res");


      if (res is Map<String, dynamic>) {
        final code = res['code'];

        if (code == 200 || code == 201 ) {
          log('✅ Success! Product added to cart: ${res['message']}');
          return;
        }

        throw ApiError(
          message: res['message'] ?? 'Unexpected response from server',
        );
      } else {
        throw ApiError(message: 'Invalid response format');
      }
    } catch (e) {
      log('❌ addToCart ERROR: $e');
      throw ApiError(message: e.toString());
    }
  }

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

    ///------------ermove cart--------------
  Future<void> removeCartItem(int id) async {
    try {
      final res = await apiServices.delete('/cart/remove/$id',{});
      log("🔍🔍🔍🔍🔍🔍🔍 CART remove : $res");
      if (res['code'] == 200 && res['data'] == null) {

        throw ApiError(message: 'cart deleted  successfully');
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

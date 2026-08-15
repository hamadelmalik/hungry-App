import 'dart:developer';

import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';

class CartRepo {
  final ApiServices apiServices = ApiServices();

  // جلب بيانات السلة
  Future<CartModel> getCartData() async {
    final response = await apiServices.get('/cart');
    log('❌❌❌❌ RAW CART RESPONSE: $response');
    return CartModel.fromJson(response);
  }

  // إضافة منتج للسلة
  Future<bool> addToCart(Map<String, dynamic> body) async {
    try {
      await apiServices.post('/cart/add', body);
      return true;
    } catch (e) {
      throw ApiError(message: 'Failed to add to cart');
    }
  }

  // تحديث كمية منتج
  Future<bool> updateCartItem(int itemId, int quantity) async {
    try {
      await apiServices.put('/cart/update/$itemId', {"quantity": quantity});
      return true;
    } catch (e) {
      throw ApiError(message: 'Failed to update cart item');
    }
  }

  // حذف منتج من السلة
  Future<bool> removeCartItem(int itemId) async {
    try {
      await apiServices.delete('/cart/remove/$itemId');
      return true;
    } catch (e) {
      throw ApiError(message: 'Failed to remove cart item');
    }
  }

  // تفريغ السلة بالكامل
  Future<bool> clearCart() async {
    try {
      await apiServices.delete('/cart/clear');
      return true;
    } catch (e) {
      throw ApiError(message: 'Failed to clear cart');
    }
  }
}

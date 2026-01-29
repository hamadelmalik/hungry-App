import 'dart:convert';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';

class CartRepo {
  ApiServices apiServices = ApiServices();

  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      print('🔥 addToCart CALLED');

      // استقبل الـ response
      final resRaw = await apiServices.post('/cart/add', cartData.toJson());

      // لو String → decode
      final res = resRaw is String ? jsonDecode(resRaw) : resRaw;

      // طباعة كل شيء
      print('🔥 Response type: ${res.runtimeType}');
      print('🔥 Response value: $res');

      // التعامل مع Map
      if (res is Map<String, dynamic>) {
        final status = res['status'] ?? res['StatusCode'] ?? 200;
        final message = res['message'] ?? 'Added to cart';

        if (status == 200 || status == 201) {
          print('✅ Success: $message');
          return;
        } else {
          throw ApiError(message: message);
        }
      }

      // التعامل مع List
      if (res is List) {
        if (res.isEmpty) throw ApiError(message: 'Empty response list');

        final first = res[0];
        if (first is Map<String, dynamic>) {
          final status = first['status'] ?? first['StatusCode'] ?? 200;
          final message = first['message'] ?? 'Added to cart';

          if (status == 200 || status == 201) {
            print('✅✅✅✅ Success: $message');
            return;
          } else {
            throw ApiError(message: message);
          }
        } else {
          throw ApiError(message: 'Unexpected List element type: $first');
        }
      }

      // أي response غريب
      throw ApiError(message: 'Unexpected response format: $res');
    } catch (e) {
      print('❌❌❌❌❌❌ addToCart ERROR: $e');
      throw ApiError(message: e.toString());
    }
  }
}
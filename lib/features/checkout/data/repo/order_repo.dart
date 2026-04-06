
import 'dart:developer';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/checkout/data/model/order_model.dart';
class OrderRepo {
  final ApiServices apiServices = ApiServices();

  Future<OrderModel?> saveOrder(OrderModel orderData) async {
    try {
      final response = await apiServices.post('/orders', orderData.toJson());

      log("❌❌❌❌RAW RESPONSE: $response");

      if (response['status'] == true) {
        final data = response['order']; // 👈 هنا الصح

        return OrderModel.fromJson(data);
      } else {
        log('❌ Error saving order: ${response['message']}');
        return null;
      }
    } catch (e) {
      log('❌ saveOrder ERROR: $e');
      throw ApiError(message: e.toString());
    }
  }
}
import 'dart:developer';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/order/data/model/order_model.dart';

class OrderRepo {
  final ApiServices apiServices = ApiServices();

  Future<OrderModel?> createOrder(OrderModel order) async {
    try {
      final response = await apiServices.post(
        '/orders',
        order.toJson(),
      );

      log('🔥 RAW RESPONSE: $response');
      log('🔥 RESPONSE TYPE: ${response.runtimeType}');

      if (response is! Map) {
        log('❌ Response is not Map');
        return null;
      }

      final data = Map<String, dynamic>.from(response);

      if (data['status'] == true && data['order'] != null) {
        final orderData = data['order'];

        log('🔥 ORDER DATA: $orderData');
        log('🔥 ORDER TYPE: ${orderData.runtimeType}');

        if (orderData is Map) {
          return OrderModel.fromJson(
            Map<String, dynamic>.from(orderData),
          );
        }
      }

      log('❌ ORDER FAILED RESPONSE: $data');
      return null;

    } catch (e, stack) {
      log('🔥🔥 CREATE ORDER ERROR: $e');
      log('STACK: $stack');
      return null;
    }
  }
//getOrderById
  Future<OrderModel?> getOrderById(int orderId) async {
    try {
      final response = await apiServices.get('/orders/$orderId');

      log("GET ORDER RESPONSE: $response");

      if (response['status'] == true) {
        final data = response['order'];

        if (data == null) {
          throw ApiError(message: 'Order data not found');
        }

        return OrderModel.fromJson(data);
      }

      log("Order Error: ${response['message'] ?? 'Unknown error'}");
      return null;

    } catch (e, stack) {
      log("getOrderById ERROR: $e");
      log("STACK: $stack");

      if (e is ApiError) rethrow;

      throw ApiError(message: e.toString());
    }
  }


}

import 'dart:developer';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/order/data/model/order_model.dart';

class OrderRepo {
  final ApiServices apiServices = ApiServices();

  Future<OrderModel?> saveOrder(OrderModel orderData) async {
    try {
      final response = await apiServices.post(
        '/orders',
        orderData.toJson(),
      );

      log("ORDER RESPONSE: $response");

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
      log("saveOrder ERROR: $e");
      log("STACK: $stack");

      if (e is ApiError) rethrow;

      throw ApiError(message: e.toString());
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

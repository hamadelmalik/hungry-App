import 'dart:developer';

import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/payment/data/models/invoice_model.dart';

class PaymentRepo {
  final ApiServices apiServices = ApiServices();

  Future<String?> createPayment(int orderId) async {
    try {
      final response = await apiServices.post(
        '/kashier/payment',
        {
          'order_id': orderId,
        },
      );

      log('🔥 PAYMENT RESPONSE: $response');
      log('🔥 PAYMENT RESPONSE TYPE: ${response.runtimeType}');

      if (response is! Map) {
        throw ApiError(
          message: 'Invalid payment response',
        );
      }

      final data = Map<String, dynamic>.from(response);

      if (data['success'] == true && data['sessionUrl'] != null) {
        final sessionUrl = data['sessionUrl'].toString();

        log('🔥 KASHIER SESSION URL: $sessionUrl');

        return sessionUrl;
      }

      throw ApiError(
        message: data['message']?.toString() ??
            'Failed to create payment',
      );
    } catch (e, stack) {
      log('🔥 CREATE PAYMENT ERROR: $e');
      log('STACK: $stack');

      if (e is ApiError) {
        rethrow;
      }

      throw ApiError(
        message: e.toString(),
      );
    }
  }

  //------------createSdkPayment------------
  //------------createSdkPayment------------
  Future<String> createSdkPayment(int orderId) async {
    final response = await apiServices.post(
      '/kashier/sdk-payment',
      {
        'order_id': orderId,
      },
    );

    log('🔥 SDK PAYMENT RESPONSE: $response');

    if (response is! Map) {
      throw ApiError(
        message: 'Invalid SDK payment response',
      );
    }

    final data = Map<String, dynamic>.from(response);

    if (data['success'] == true && data['sessionId'] != null) {
      final sessionId = data['sessionId'].toString();

      log('🔥 KASHIER SESSION ID: $sessionId');

      return sessionId;
    }

    throw ApiError(
      message: data['message']?.toString() ??
          'Failed to create SDK payment',
    );
  }
  //------------getInvoice--------------
  Future<InvoiceModel> getInvoice(int orderId) async {
    final response = await apiServices.get('/orders/$orderId/invoice');

    log('🔥 INVOICE RESPONSE: $response');
    log('🔥 RESPONSE TYPE: ${response.runtimeType}');

    return InvoiceModel.fromJson(response['invoice']);
  }

}
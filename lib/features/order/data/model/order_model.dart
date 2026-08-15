import 'package:hungry/features/order/data/model/order_item_model.dart';

class OrderModel {
  final int? id;
  final List<OrderItemModel> items;
  final double total;
  final double taxes;
  final double deliveryFees;
  final String? paymentMethod;
  final String? transactionId;
  final String? estimatedDeliveryTime;
  final String? status;

  OrderModel({
    this.id,
    required this.items,
    required this.total,
    required this.taxes,
    required this.deliveryFees,
    this.paymentMethod,
    this.transactionId,
    this.estimatedDeliveryTime,
    this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),

      items: json['items'] is List
          ? (json['items'] as List)
          .map(
            (item) => OrderItemModel.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
          .toList()
          : [],

      total: double.tryParse(
        json['total']?.toString() ?? '',
      ) ??
          0.0,

      taxes: double.tryParse(
        json['taxes']?.toString() ?? '',
      ) ??
          0.0,

      deliveryFees: double.tryParse(
        json['delivery_fees']?.toString() ?? '',
      ) ??
          0.0,

      paymentMethod: json['payment_method']?.toString(),

      transactionId: json['transaction_id']?.toString(),

      estimatedDeliveryTime:
      json['estimated_delivery_time']?.toString(),

      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items
          .map((item) => item.toJson())
          .toList(),

      "total": total,
      "taxes": taxes,
      "delivery_fees": deliveryFees,
      "payment_method": paymentMethod,
      "transaction_id": transactionId,
      "estimated_delivery_time": estimatedDeliveryTime,
    };
  }
}
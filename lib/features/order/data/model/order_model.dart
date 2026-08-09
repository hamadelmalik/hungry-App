import 'package:hungry/features/order/data/model/order_item_model.dart';

class OrderModel {
  final List<OrderItemModel> items;
  final double total;
  final double taxes;
  final double deliveryFees;
  final String? paymentMethod;

  OrderModel({
    required this.items,
    required this.total,
    required this.taxes,
    required this.deliveryFees,
    this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      items: (json["items"] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      total: double.tryParse(json["total"].toString()) ?? 0.0,
      taxes: double.tryParse(json["taxes"].toString()) ?? 0.0,
      deliveryFees: double.tryParse(json["delivery_fees"].toString()) ?? 0.0,
      paymentMethod: json["payment_method"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((e) => e.toJson()).toList(),
      "total": total,
      "taxes": taxes,
      "delivery_fees": deliveryFees,
      "payment_method": paymentMethod,
    };
  }
}

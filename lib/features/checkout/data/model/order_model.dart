import 'order_item_model.dart';

import 'order_item_model.dart';

class OrderModel {
  final List<OrderItemModel> items;
  final double totalPrice;

  OrderModel({
    required this.items,
    required this.totalPrice,
  });

  // تحويل للـ JSON (عشان تبعت للـ API)
  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total_price': totalPrice,
    };
  }

  // تحويل من JSON (لو هتستقبل بيانات من API)
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      items: (json['items'] as List? ?? [])
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
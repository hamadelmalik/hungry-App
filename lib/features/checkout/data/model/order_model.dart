import 'order_item_model.dart';


class OrderModel {
  final List<OrderItemModel> items;
  final double total;

  OrderModel({
    required this.items,
    required this.total,
  });

  // to json (send to Laravel)
  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }

  // from json (receive from Laravel)
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      total: double.tryParse(json['total'].toString()) ?? 0.0,
      items: (json['items'] as List? ?? [])
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
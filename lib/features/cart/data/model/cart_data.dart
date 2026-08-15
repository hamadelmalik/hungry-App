import 'cart_item_model.dart';

class CartData {
  final List<CartItemModel> items;
  final double totalPrice;

  CartData({
    required this.items,
    required this.totalPrice,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      items: (json["items"] as List<dynamic>? ?? [])
          .map((e) => CartItemModel.fromJson(
        e as Map<String, dynamic>,
      ))
          .toList(),

      totalPrice: double.tryParse(
        json["total_price"].toString(),
      ) ??
          0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((e) => e.toJson()).toList(),
      "total_price": totalPrice,
    };
  }
}

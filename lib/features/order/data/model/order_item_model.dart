class OrderItemModel {
  final int productId;
  final int quantity;
  final double spicy;
  final double? totalPrice;
  final List<Map<String, dynamic>> selectedOptions;

  OrderItemModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    this.totalPrice,
    this.selectedOptions = const [],
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: int.tryParse(
        json['product_id']?.toString() ?? '',
      ) ??
          0,

      quantity: int.tryParse(
        json['quantity']?.toString() ?? '',
      ) ??
          1,

      spicy: double.tryParse(
        json['spicy']?.toString() ?? '',
      ) ??
          0.0,

      totalPrice: double.tryParse(
        json['total_price']?.toString() ?? '',
      ),

      selectedOptions:
      json['options'] is List
          ? (json['options'] as List)
          .map(
            (e) => Map<String, dynamic>.from(e),
      )
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'spicy': spicy,
      'options': selectedOptions,
    };
  }
}
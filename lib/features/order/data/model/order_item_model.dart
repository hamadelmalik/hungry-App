class OrderItemModel {
  final int productId;
  final int quantity;
  final double spicy;
  final double totalPrice;

  // الإضافات (خريطة من نوع Map<String, List<dynamic>>)
  final Map<String, List<dynamic>> optionsByType;

  OrderItemModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.totalPrice,
    required this.optionsByType,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json["product_id"],
      quantity: json["quantity"],
      spicy: double.tryParse(json["spicy"].toString()) ?? 0.0,
      totalPrice: double.tryParse(json["total_price"].toString()) ?? 0.0,
      optionsByType: Map<String, List<dynamic>>.from(json["options_by_type"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "spicy": spicy,
      "total_price": totalPrice,
      "options_by_type": optionsByType,
    };
  }
}

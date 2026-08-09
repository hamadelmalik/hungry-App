class CartItemModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double spicy;
  final double totalPrice;
  final Map<String, List<dynamic>>? options;
  // الإضافات حسب النوع
  final Map<String, List<dynamic>>? optionsByType;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.spicy,
    required this.totalPrice,
    this.options,
     this.optionsByType,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json["item_id"],
      productId: json["product_id"],
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      quantity: json["quantity"] ?? 1,
      spicy: double.tryParse(json["spicy"].toString()) ?? 0.0,
      totalPrice: double.tryParse(json["total_price"].toString()) ?? 0.0,
      optionsByType: Map<String, List<dynamic>>.from(json["options_by_type"] ?? {}),
      options: Map<String, List<dynamic>>.from(json["options"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "item_id": itemId,
      "product_id": productId,
      "name": name,
      "image": image,
      "quantity": quantity,
      "spicy": spicy,
      "total_price": totalPrice,
      "options_by_type": optionsByType,
    };
  }
}

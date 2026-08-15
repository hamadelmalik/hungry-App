class CartItemModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double spicy;
  final double totalPrice;
  final List<Map<String, dynamic>> options;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.spicy,
    required this.totalPrice,
    required this.options,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['item_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 1,
      spicy: double.tryParse(
        json['spicy']?.toString() ?? '0',
      ) ??
          0.0,
      totalPrice: double.tryParse(
        json['total_price']?.toString() ?? '0',
      ) ??
          0.0,
      options: (json['options'] as List?)
          ?.map(
            (e) => Map<String, dynamic>.from(e),
      )
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': [
        {
          'product_id': productId,
          'quantity': quantity,
          'spicy': spicy,
          'option_type_id': null,
          'option_id': null,
        },
      ],
    };
  }
}
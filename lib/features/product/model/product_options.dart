class ProductOptionModel {
  final int id;
  final String name;
  final String image;
  final int typeId;     // 1 = topping, 2 = side option
  final double? price;

  ProductOptionModel({
    required this.id,
    required this.name,
    required this.image,
    required this.typeId,
    this.price,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      typeId: json['type_id'] ?? 0,
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
    );
  }
}
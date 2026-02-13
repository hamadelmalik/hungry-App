class ProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String? rate;
  final int categoryId;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
     this.rate,
    required this.categoryId,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?.toString() ?? '0.00',
      rate: json['rating']?.toString() ?? '0.00', // default 0.00
      categoryId: json['category_id'] ?? 0,
      image: json['image'] ?? '',
    );

  }
}
class OptionModel {
  final int id;
  final String name;
  final String price;
  final String image;
  final int typeId;

  OptionModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.typeId,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      typeId: json['type_id'],
    );
  }
}
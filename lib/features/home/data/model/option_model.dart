class OptionModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final int typeId;

  OptionModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.typeId,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0,
      typeId: int.tryParse(json['type_id'].toString()) ?? 0,
    );
  }

  /// هذا الـ toJson خاص بالإرسال للـ API
  Map<String, dynamic> toOrderJson() {
    return {
      "option_type_id": typeId,
      "option_id": id,
      "quantity": 1,
      "unit_price": price,
      "total_price": price,
    };

  }
}

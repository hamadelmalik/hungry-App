class OptionModel {
  final int id;
  final String name;
  final String image;
  final int typeId;
  OptionModel({required this.id, required this.name,required this.image, required this.typeId});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'type_id': typeId,
    };
  }

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      typeId: int.tryParse(json['type_id'].toString()) ?? 0,
    );
  }
}
class OptionModel {
  int id;
  String name;
  String image;

  OptionModel({required this.id, required this.name, required this.image});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

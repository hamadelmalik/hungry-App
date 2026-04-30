import 'package:hungry/features/home/data/model/option_model.dart';

class OptionType {
  final int id;
  final String name;
  final List<OptionModel> options;

  OptionType({
    required this.id,
    required this.name,
    required this.options,
  });

  factory OptionType.fromJson(Map<String, dynamic> json) {
    return OptionType(
      id: json['id'],
      name: json['name'],
      options: (json['options'] as List)
          .map((e) => OptionModel.fromJson(e))
          .toList(),
    );
  }
}
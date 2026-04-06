import 'package:hungry/features/home/data/model/option_model.dart';

class OptionsResponse {
  final bool status;
  final Map<String, List<OptionModel>> data;

  OptionsResponse({
    required this.status,
    required this.data,
  });

  factory OptionsResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<OptionModel>> parsedData = {};

    (json['data'] as Map<String, dynamic>).forEach((key, value) {
      parsedData[key] = (value as List)
          .map((e) => OptionModel.fromJson(e))
          .toList();
    });

    return OptionsResponse(
      status: json['status'],
      data: parsedData,
    );
  }
}
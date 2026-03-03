import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';

class OptionRepo {
  final ApiServices apiServices = ApiServices();

  Future<Map<String, List<OptionModel>>> getOptionsResponse() async {
    final response = await apiServices.get('/options');

    if (response['status'] == true) {
      final Map<String, dynamic> data = response['data'];

      final Map<String, List<OptionModel>> optionsByType = {};

      data.forEach((key, value) {
        optionsByType[key] = (value as List)
            .map((e) => OptionModel.fromJson(e))
            .toList();
      });

      return optionsByType;

    } else {
      throw Exception('Failed to load options');
    }
  }
}
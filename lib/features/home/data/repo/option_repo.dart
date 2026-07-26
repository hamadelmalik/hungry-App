import 'dart:developer';

import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/home/data/model/option_model.dart';
import 'package:hungry/features/home/data/model/option_type.dart';

class OptionRepo {
  final ApiServices apiServices = ApiServices();

  // Fetch option types (topping, side_options)
  Future<List<OptionType>> getOptionTypes() async {
    try {
      final response = await apiServices.get('/option-types-new');

      final List data = response['data'];

      return data
          .map((e) => OptionType.fromJson(e))
          .toList();

    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  // Fetch options (tomato, cheese, fries...)
  Future<Map<String, List<OptionModel>>> getOptions() async {
    try {
      final response = await apiServices.get('/options');

      if (response['status'] == true) {
        final Map<String, dynamic> data = response['data'];

        final Map<String, List<OptionModel>> options = {};

        data.forEach((key, value) {
          options[key] = (value as List)
              .map((e) => OptionModel.fromJson(e))
              .toList();
        });

        return options;
      } else {
        throw ApiError(message: 'Failed to load options');
      }

    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
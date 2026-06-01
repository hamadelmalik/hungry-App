import 'dart:developer';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/home/data/model/option_type.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/option_model.dart';

class ProductRepo {
  ApiServices apiServices = ApiServices();

  //---getProduct-----------
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiServices.get('/products');

      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //-------------getTopping-----------//
  Future<List<OptionModel>> getTopping() async {
    try {
      final response = await apiServices.get('/toppings');

      return (response['data'] as List? ?? []).map((topping) {
        return OptionModel.fromJson(topping);
      }).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

//-------------getOption-----------
  Future<List<OptionModel>> getOption() async {
    try {
      final response = await apiServices.get('/side-options');

      return (response['data'] as List? ?? []).map((side) {
        return OptionModel.fromJson(side);
      }).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //------------getNewOptions

  Future<List<OptionType>> getNewOption() async {
    try {
      final response = await apiServices.get('/option-types-new');

      final List data = response['data'];
      log(data.toString());

      return data.map((e) => OptionType.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
//----------------searchProduct----------------------//
  Future<List<ProductModel>> searchProducts(String name) async {
    try {
      final response = await apiServices.get('/products', param:{'name':name});
      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {

      log(e.toString());
      return [];
    }
  }
//----------------------category -------------


}

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

import 'dart:developer';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';

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
  Future<List<ToppingModel>> getTopping() async {
    try {
      final response = await apiServices.get('/toppings');

      return (response['data'] as List? ?? []).map((topping) {
        return ToppingModel.fromJson(topping);
      }).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

//-------------getOPTION-----------
  Future<List<ToppingModel>> getOption() async {
    try {
      final response = await apiServices.get('/side-options');

      return (response['data'] as List? ?? []).map((side) {
        return ToppingModel.fromJson(side);
      }).toList();
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



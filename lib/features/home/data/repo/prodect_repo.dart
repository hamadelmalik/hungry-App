

import 'dart:developer';

import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/home/data/model/product_model.dart';

class ProductRepo{
  ApiServices apiServices=ApiServices();
  //---getProduct-----------
  Future<List<ProductModel>> getProducts () async {
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


}


  //searchProduct-------------








import 'dart:developer';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/cart/data/model/cart_item_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';

class HomeRepo {
  final ApiServices apiServices = ApiServices();

  //---getProduct-----------
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiServices.get('/products');

      return List<ProductModel>.from(
        (response['data'] as List)
            .map((e) => ProductModel.fromJson(e)),
      );
    } on ApiError catch (e) {
      throw ApiError(message: e.toString());// أو rethrow
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }


  Future<void> addToCart(CartItemModel cartData) async {
    try {
      final res = await apiServices.post('/cart/add', cartData.toJson());

      log('✅ Success! Product added to cart: ${res['message']}');


    } catch (e) {
      log('❌ addToCart ERROR: $e');
      throw ApiError(message: e.toString());
    }
  }


}



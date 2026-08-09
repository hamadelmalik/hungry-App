import 'cart_data.dart';

class CartModel {
  final CartData cartData;

  CartModel({required this.cartData});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartData: CartData.fromJson(json['cart']),
    );
  }
}

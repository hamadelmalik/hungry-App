import 'cart_data.dart';

class CartModel {
  final CartData cartData;

  CartModel({required this.cartData});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid cart response');
    }

    return CartModel(
      cartData: CartData.fromJson(data),
    );

  }
}

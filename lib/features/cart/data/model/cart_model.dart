//---------to Backend--------------
import 'package:hungry/features/home/data/model/option_model.dart';

class CartModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<OptionModel> selectedOptions;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.selectedOptions,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'spicy': spicy,
      'options': selectedOptions.map((opt) => opt.toJson()).toList(),
    };
  }
}

class CartRequestModel {
  final List<CartModel> items;

  CartRequestModel({required this.items});

  Map<String, dynamic> toJson() => {
    "items": items.map((e) => e.toJson()).toList(),
  };
}

//-------response from Backend---------------
class GetCartResponseModel {
  final int code;
  final String message;
  final CartDataModel cartData;

  GetCartResponseModel({
    required this.code,
    required this.message,
    required this.cartData,
  });

  factory GetCartResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCartResponseModel(
      code: json['code'] ?? 200,
      message: json['message']?.toString() ?? '',
      cartData: CartDataModel.fromJson(json['data']),
    );
  }
}

class CartDataModel {
  final String totalPrice;
  final List<CartItemModel> items;

  CartDataModel({
    required this.totalPrice,
    required this.items,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      totalPrice: json['total_price']?.toString() ?? '0',
      items: (json['items'] as List? ?? [])
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
    );
  }
}

class CartItemModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double spicy;
  final List<OptionModel> options;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.spicy,
    required this.options,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['item_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      unitPrice: double.tryParse(json['unit_price'].toString()) ?? 0.0,
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      spicy: double.tryParse(json['spicy'].toString()) ?? 0.0,
      options: (json['options'] as List? ?? [])
          .map((e) => OptionModel.fromJson(e))
          .toList(),
    );
  }
}

//---------to Backend--------------
class CartModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;

  final List<int> options;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    this.toppings = const [],
    this.options = const [],
  });

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
    'spicy': spicy,
     "toppings": toppings,
   "side_options": options,
  };
}

class CartRequestModel {
  final List<CartModel> items;

  CartRequestModel({required this.items});

  Map<String, dynamic> toJson() => {
    "items": items.map((e) => e.toJson()).toList(),
  };
}

//-------response  from Backend---------------
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
  final int id;

  final String totalPrice;
  final List<CartItemModel> items;

  CartDataModel({
    required this.id,
    required this.totalPrice,
    required this.items,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['id'] ?? 0,
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
  final double price;
  final double spicy;
  final List<int> topping;
  final List<int> sideOption;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.topping,
    required this.sideOption,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['item_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      spicy: double.tryParse(json['spicy'].toString()) ?? 0.0,
      topping: List<int>.from(json['topping'] ?? []),
      sideOption: List<int>.from(json['side_option'] ?? []),
    );
  }
}

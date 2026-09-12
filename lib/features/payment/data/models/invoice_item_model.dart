class InvoiceItemModel {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double basePrice;
  final double optionPrice;
  final double totalPrice;
  final double spicy;
  final InvoiceProductModel? product;

  InvoiceItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.basePrice,
    required this.optionPrice,
    required this.totalPrice,
    required this.spicy,
    this.product,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      basePrice: (json['base_price'] as num).toDouble(),
      optionPrice: (json['option_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      spicy: (json['spicy'] as num).toDouble(),
      product: json['product'] != null
          ? InvoiceProductModel.fromJson(json['product'])
          : null,
    );
  }
}

class InvoiceProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String? image;

  InvoiceProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
  });

  factory InvoiceProductModel.fromJson(Map<String, dynamic> json) {
    return InvoiceProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class InvoiceTransactionModel {
  final int id;
  final int orderId;
  final String transactionId;
  final double amount;
  final String currency;
  final String status;
  final String gateway;

  InvoiceTransactionModel({
    required this.id,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.gateway,
  });

  factory InvoiceTransactionModel.fromJson(Map<String, dynamic> json) {
    return InvoiceTransactionModel(
      id: json['id'],
      orderId: json['order_id'],
      transactionId: json['transaction_id'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      status: json['status'],
      gateway: json['gateway'],
    );
  }
}
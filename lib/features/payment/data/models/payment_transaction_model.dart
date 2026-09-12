class PaymentTransactionModel {
  final int id;
  final int orderId;
  final String transactionId;
  final double amount;
  final String currency;
  final String status;
  final String gateway;

  PaymentTransactionModel({
    required this.id,
    required this.orderId,
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.gateway,
  });

  factory PaymentTransactionModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PaymentTransactionModel(
      id: json['id'],
      orderId: json['order_id'],
      transactionId: json['transaction_id'],
      amount: double.parse(json['amount'].toString()),
      currency: json['currency'],
      status: json['status'],
      gateway: json['gateway'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'transaction_id': transactionId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'gateway': gateway,
    };
  }
}
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


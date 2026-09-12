import 'package:hungry/features/payment/data/models/invoice_item_model.dart';

class InvoiceModel {
  final int id;
  final int userId;
  final double taxes;
  final double deliveryFees;
  final double total;
  final String paymentMethod;
  final String? transactionId;
  final String? estimatedDeliveryTime;

  final String status;
  final List<InvoiceItemModel> items;
  final List<InvoiceTransactionModel> transactions;

  InvoiceModel({
    required this.id,
    required this.userId,
    required this.taxes,
    required this.deliveryFees,
    required this.total,
    required this.paymentMethod,
    this.transactionId,
    this.estimatedDeliveryTime,

    required this.status,
    required this.items,
    required this.transactions,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      userId: json['user_id'],
      taxes: (json['taxes'] as num).toDouble(),
      deliveryFees: (json['delivery_fees'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['payment_method'],
      transactionId: json['transaction_id'],
      estimatedDeliveryTime: json['estimated_delivery_time'],

      status: json['status'],
      items: (json['items'] as List)
          .map((item) => InvoiceItemModel.fromJson(item))
          .toList(),
      transactions: (json['transactions'] as List)
          .map((transaction) =>
          InvoiceTransactionModel.fromJson(transaction))
          .toList(),
    );
  }
}
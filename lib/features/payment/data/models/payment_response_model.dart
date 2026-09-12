class PaymentResponseModel {
  final bool success;
  final String sessionUrl;
  final int order;
  final String merchantOrderId;

  PaymentResponseModel({
    required this.success,
    required this.sessionUrl,
    required this.order,
    required this.merchantOrderId,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      success: json['success'] as bool,
      sessionUrl: json['sessionUrl'] as String,
      order: json['order'] as int ,
      merchantOrderId: json['merchantOrderId'] as String,
    );
  }
}
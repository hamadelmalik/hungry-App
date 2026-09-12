abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String sessionUrl;

  PaymentSuccess(this.sessionUrl);
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);
}
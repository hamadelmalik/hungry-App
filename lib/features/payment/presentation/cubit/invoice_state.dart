import 'package:hungry/features/payment/data/models/invoice_model.dart';

abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceSuccess extends InvoiceState {
  final InvoiceModel invoice;

  InvoiceSuccess(this.invoice);
}

class InvoiceError extends InvoiceState {
  final String message;

  InvoiceError(this.message);
}
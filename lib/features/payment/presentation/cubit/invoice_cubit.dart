import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/payment/data/repo/payment_repo.dart';
import 'package:hungry/features/payment/presentation/cubit/invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final PaymentRepo paymentRepo;

  InvoiceCubit(this.paymentRepo) : super(InvoiceInitial());

  Future<void> getInvoice(int orderId) async {
    emit(InvoiceLoading());

    try {
      final invoice = await paymentRepo.getInvoice(orderId);
      emit(InvoiceSuccess(invoice));
    } catch (e) {
      emit(InvoiceError(e.toString()));
    }
  }
}
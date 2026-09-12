import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/payment/data/repo/payment_repo.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  PaymentCubit({
    required this.paymentRepo,
  }) : super(PaymentInitial());

  Future<void> createPayment(int orderId) async {
    emit(PaymentLoading());

    try {
      final sessionUrl = await paymentRepo.createPayment(orderId);

      if (sessionUrl == null || sessionUrl.isEmpty) {
        emit(PaymentError('Failed to create payment'));
        return;
      }

      emit(PaymentSuccess(sessionUrl));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
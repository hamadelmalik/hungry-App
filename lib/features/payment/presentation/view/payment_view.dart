import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:hungry/features/payment/presentation/cubit/payment_state.dart';
import 'package:hungry/features/payment/presentation/view/Kashier_view.dart';
import 'package:hungry/features/payment/presentation/view/invoice_view.dart';

class PaymentView extends StatelessWidget {
  final int orderId;

  const PaymentView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) async {
        // 🔄 إنشاء الدفع
        if (state is PaymentLoading) {
          log('🔥 PAYMENT LOADING');
        }

        // ✅ تم إنشاء جلسة Kashier
        if (state is PaymentSuccess) {
          log('🔥 Kashier SESSION URL: ${state.sessionUrl}');

          if (state.sessionUrl.isNotEmpty) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => KashierView(sessionUrl: state.sessionUrl),
              ),
            );
            if (!context.mounted) return;
            log('🔥🔥🔥🔥🔥🔥 KASHIER RESULT: $result');

            if (result == true) {
              log('🎉 PAYMENT COMPLETED');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => InvoiceView(orderId: orderId),
                ),
              );
            }
          }
        }

        // ❌ حصل خطأ
        if (state is PaymentError) {
          log('❌ PAYMENT ERROR: ${state.message}');

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Payment')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<PaymentCubit>().createPayment(orderId);
            },
            child: const Text('Pay Now'),
          ),
        ),
      ),
    );
  }
}

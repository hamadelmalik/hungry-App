import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashier_flutter_sdk/kashier_flutter_sdk.dart';

import 'package:hungry/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:hungry/features/payment/presentation/cubit/payment_state.dart';

class KashierSdkView extends StatefulWidget {
  final int orderId;

  const KashierSdkView({
    super.key,
    required this.orderId,
  });

  @override
  State<KashierSdkView> createState() => _KashierSdkViewState();
}

class _KashierSdkViewState extends State<KashierSdkView> {

  @override
  void initState() {
    super.initState();

    // Initialize Kashier SDK
    KashierSDK.initialize(
      mode: KashierMode.test,
      language: KashierLanguage.en,
      appleMerchantId: 'merchant.com.kashier.payments',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentLoading) {
          debugPrint('🔥 SDK PAYMENT LOADING');
        }

        if (state is PaymentSuccess) {
          debugPrint('🔥 SDK SESSION ID: ${state.sessionUrl}');

          KashierSDK.startPayment(
            sessionId: state.sessionUrl,
            onSuccess: (KashierPaymentResult result) {
              debugPrint('🎉 PAYMENT SUCCESS');
              debugPrint('Session: ${result.sessionId}');
              debugPrint('Status: ${result.status}');
              debugPrint('Order: ${result.orderId}');
              debugPrint('Transaction: ${result.transactionId}');
            },
            onPending: (KashierPaymentPending pending) {
              debugPrint('⏳ PAYMENT PENDING');
              debugPrint('Order: ${pending.orderId}');
              debugPrint('Transaction: ${pending.transactionId}');
              debugPrint('Message: ${pending.message}');
            },
            onFailure: (KashierPaymentError error) {
              debugPrint('❌ PAYMENT FAILED');
              debugPrint('Code: ${error.code.name}');
              debugPrint('Message: ${error.message}');
            },
          );
        }

        if (state is PaymentError) {
          debugPrint('❌ SDK PAYMENT ERROR: ${state.message}');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kashier Payment'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // مؤقتًا لا ننشئ Session جديدة
              // نختبر الـ SDK بالـ Session الموجودة
              KashierSDK.startPayment(
                sessionId: '6aa6b9624da1806751e60742',
                onSuccess: (KashierPaymentResult result) {
                  debugPrint('🎉 PAYMENT SUCCESS');
                  debugPrint('Session: ${result.sessionId}');
                  debugPrint('Status: ${result.status}');
                  debugPrint('Order: ${result.orderId}');
                  debugPrint('Transaction: ${result.transactionId}');
                },
                onPending: (KashierPaymentPending pending) {
                  debugPrint('⏳ PAYMENT PENDING');
                  debugPrint('Order: ${pending.orderId}');
                  debugPrint('Transaction: ${pending.transactionId}');
                  debugPrint('Message: ${pending.message}');
                },
                onFailure: (KashierPaymentError error) {
                  debugPrint('❌ PAYMENT FAILED');
                  debugPrint('Code: ${error.code.name}');
                  debugPrint('Message: ${error.message}');
                },
              );
            },
            child: const Text('Pay with Kashier'),
          ),
        ),
      ),
    );
  }
}
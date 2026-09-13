import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/di/dependency_injection.dart';
import 'package:hungry/features/auth/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/cubit/profile_cubit.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/home/cubit/home_cubit.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/order/data/repo/order_repo.dart';
import 'package:hungry/features/order/view/cubit/order_cubit.dart';
import 'package:hungry/features/payment/data/repo/payment_repo.dart';
import 'package:hungry/features/payment/presentation/cubit/invoice_cubit.dart';
import 'package:hungry/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:hungry/features/payment/presentation/view/kashier_sdk_view.dart';
import 'package:kashier_flutter_sdk/kashier_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cartRepo = CartRepo();
    return MultiBlocProvider(
      providers: [
        // Auth
        BlocProvider(create: (_) => AuthCubit(authRepo: authRepo)),

        // Profile
        BlocProvider(
          create: (_) => ProfileCubit(profileRepo)..getProfileData(),
        ),

        // Home
        BlocProvider(create: (_) => HomeCubit()..getProducts()),

        // Cart
        BlocProvider(
          create: (_) =>
              CartCubit(cartRepo: cartRepo, authRepo: authRepo)..initCart(),
        ),
        //order
        BlocProvider(
          create: (_) => OrderCubit(orderRepo: OrderRepo(), cartRepo: cartRepo),
        ),
        //payment
        BlocProvider(
          create: (context) => PaymentCubit(paymentRepo: PaymentRepo()),
        ),
        //invoice
        BlocProvider(create: (context) => InvoiceCubit(PaymentRepo())),
      ],

      child: KashierPaymentProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'hungerApp',
        
          theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        
          home:  const KashierSdkView(
            orderId: 74,
        
        
          ),
        ),
      ),
    );
  }
}

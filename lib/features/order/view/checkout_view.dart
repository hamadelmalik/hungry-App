
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';


import 'package:hungry/features/order/data/model/order_item_model.dart';
import 'package:hungry/features/order/data/model/order_model.dart';
import 'package:hungry/features/order/view/cubit/order_cubit.dart';
import 'package:hungry/features/order/view/cubit/order_states.dart';

import 'package:hungry/features/order/view/widget/order_details_widget.dart';
import 'package:hungry/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:hungry/features/payment/presentation/cubit/payment_state.dart';
import 'package:hungry/features/payment/presentation/view/Kashier_view.dart';
import 'package:hungry/features/payment/presentation/view/invoice_view.dart';
import 'package:hungry/shared/custom_snack.dart';

import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/isloading_btn.dart';

class CheckoutView extends StatefulWidget {
  final String totalPrice;
  final List<OrderItemModel> cartItems;
  final VoidCallback? onCartCleared;

  const CheckoutView({
    super.key,
    required this.totalPrice,
    required this.cartItems,
    this.onCartCleared,
  });

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? selectedMethod = 'cash';

  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    final subtotal = double.parse(widget.totalPrice);

    const taxes = 0.3;
    const deliveryFees = 0.2;

    final total = (
        subtotal +
            taxes +
            deliveryFees
    ).toStringAsFixed(2);

    return MultiBlocListener(
      listeners: [
        BlocListener<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is CreateOrderSuccess) {
              final order = state.order;

              if (selectedMethod == 'cash') {
                context.read<CartCubit>().clearCart();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InvoiceView(
                      orderId: order.id!,
                    ),
                  ),
                );
              }

              if (selectedMethod == 'card') {
                if (order.id == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order ID not found'),
                    ),
                  );
                  return;
                }

                context.read<PaymentCubit>().createPayment(order.id!);
              }
            }
            if (state is CreateOrderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnack(state.message),
              );
            }
          },
        ),
        BlocListener<PaymentCubit, PaymentState>(

          listener: (context, state) {
            if (state is PaymentSuccess) {
              final sessionUrl = state.sessionUrl;

              log('🔥 Kashair SESSION URL: $sessionUrl');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => KashierView(
                    sessionUrl: sessionUrl,
                  ),
                ),
              );
              context.read<CartCubit>().clearCart();
            }

            if (state is PaymentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnack(state.message),
              );
            }
          },

            // Payment listener

        ),
      ],


      child: BlocBuilder<OrderCubit, OrderState>(

        builder: (context, state) {
          final cubit = context.read<OrderCubit>();
      
          return Scaffold(
            backgroundColor: Colors.white,
      
            // =========================
            // AppBar
            // =========================
      
            appBar: AppBar(
              toolbarHeight: 60,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorPalette.primaryColor,
                  size: 22,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
      
            // =========================
            // Body
            // =========================
      
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: 140,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Order Summary',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
      
                    const Gap(10),
      
                    OrderDetailsWidget(
                      order: subtotal.toStringAsFixed(2),
                      taxes: taxes.toStringAsFixed(2),
                      fees: deliveryFees.toStringAsFixed(2),
                      total: total,
                    ),
      
                    const Gap(25),
      
                    const CustomText(
                      text: 'Payment Method',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
      
                    const Gap(20),
      
                    // =========================
                    // Cash Payment
                    // =========================
      
                    ListTile(
                      onTap: () {
                        setState(() {
                          selectedMethod = 'cash';
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      tileColor: const Color(0xff3C2F2F),
                      leading: Image.asset(
                        AssetsPath.dollar,
                        width: 50,
                      ),
                      title: const CustomText(
                        text: 'Cash on Delivery',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      trailing: Radio<String>(
                        value: 'cash',
                        groupValue: selectedMethod,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            selectedMethod = value;
                          });
                        },
                      ),
                    ),
      
                    const Gap(12),
      
                    // =========================
                    // Card Payment
                    // =========================
      
                    ListTile(
                      onTap: () {
                        setState(() {
                          selectedMethod = 'card';
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      tileColor: Colors.blue.shade900,
                      leading: Image.asset(
                        AssetsPath.Asset,
                        width: 50,
                      ),
                      title: const CustomText(
                        text: 'Customer card',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: const CustomText(
                        text: '******2345',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      trailing: Radio<String>(
                        value: 'card',
                        groupValue: selectedMethod,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            selectedMethod = value;
                          });
                        },
                      ),
                    ),
      
                    const Gap(15),
      
                    Row(
                      children: const [
                        Icon(
                          Icons.check_box,
                          color: Colors.red,
                        ),
                        Gap(10),
                        CustomText(
                          text:
                          'Save card details for future payments',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      
            // =========================
            // Bottom Payment Bar
            // =========================
      
            bottomSheet: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    // =========================
                    // Total
                    // =========================
      
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Total',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: total,
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
      
                    // =========================
                    // Pay Now
                    // =========================
      
                    LoadingButton(
                      height: 50,
                      width: 150,
                      text: 'Pay Now',
                      isLoading: state is CreateOrderLoading,
                      backgroundColor:
                      ColorPalette.primaryColor,
                      onPressed: () {
                        if (state is CreateOrderLoading) {
                          return;
                        }
      
                        final items =
                        widget.cartItems.map((item) {
                          return OrderItemModel(
                            productId: item.productId,
                            quantity: item.quantity,
                            spicy: item.spicy,
                            totalPrice: item.totalPrice,
                            selectedOptions:
                            item.selectedOptions,
                          );
                        }).toList();
      
                        final order = OrderModel(
                          items: items,
                          total:
                          double.parse(widget.totalPrice),
                          taxes: taxes,
                          deliveryFees: deliveryFees,
                          paymentMethod: selectedMethod,
                        );
      
                        log(
                          'ORDER JSON BEFORE SEND: '
                              '${order.toJson()}',
                        );
      
                        cubit.createOrder(order);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

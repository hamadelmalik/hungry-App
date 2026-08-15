import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';

import 'package:hungry/features/cart/data/repo/cart_repo.dart';

import 'package:hungry/features/order/data/model/order_item_model.dart';
import 'package:hungry/features/order/data/model/order_model.dart';
import 'package:hungry/features/order/data/repo/order_repo.dart';

import 'package:hungry/features/order/view/widget/order_details_widget.dart';
import 'package:hungry/features/order/view/widget/order_invoice_view.dart';

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

  final OrderRepo orderRepo = OrderRepo();
  final CartRepo cartRepo = CartRepo();

  // =========================
  // Clear Cart
  // =========================

  Future<bool> clearCart() async {
    try {
      await cartRepo.clearCart();
      return true;
    } catch (e) {
      log('CLEAR CART ERROR: $e');
      return false;
    }
  }

  // =========================
  // Handle Payment
  // =========================

  Future<void> handlePayment() async {
    if (isLoading) return;

    if (selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select payment method'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // =========================
      // Prepare Order Items
      // =========================

      final items = widget.cartItems.map((item) {
        return OrderItemModel(
          productId: item.productId,
          quantity: item.quantity,
          spicy: item.spicy,
          totalPrice: item.totalPrice,
          selectedOptions: item.selectedOptions,
        );
      }).toList();

      // =========================
      // Create Order
      // =========================

      final order = OrderModel(
        items: items,
        total: double.parse(widget.totalPrice),
        taxes: 0.3,
        deliveryFees: 0.2,
        paymentMethod: selectedMethod,
      );

      log(
        'ORDER JSON BEFORE SEND: ${order.toJson()}',
      );

      // =========================
      // Send Order
      // =========================

      final result = await orderRepo.createOrder(order);

      // =========================
      // Success
      // =========================

      if (result != null) {
        // Clear cart
        await clearCart();

        widget.onCartCleared?.call();

        // Convert OrderItemModel -> InvoiceItem
        final invoiceItems = widget.cartItems.map((item) {
          final itemTotal = item.totalPrice ?? 0.0;

          return InvoiceItem(
            name: 'Product #${item.productId}',
            quantity: item.quantity,
            price: item.quantity > 0
                ? itemTotal / item.quantity
                : 0.0,
            total: itemTotal,
          );
        }).toList();

        // Final total
        final invoiceTotal =
            double.parse(widget.totalPrice) + 0.3 + 0.2;

        // Open Invoice
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OrderInvoiceView(
              orderNumber: result.id ?? 0,

              date:
              '${DateTime.now().day.toString().padLeft(2, '0')}/'
                  '${DateTime.now().month.toString().padLeft(2, '0')}/'
                  '${DateTime.now().year}',

              items: invoiceItems,

              total: invoiceTotal,

              paymentMethod:
              result.paymentMethod ?? selectedMethod ?? 'cash',
            ),
          ),
        );

        return;
      }

      // =========================
      // Failed
      // =========================

      throw ApiError(
        message: 'Order failed',
      );
    } catch (e, stack) {
      log('CREATE ORDER ERROR: $e');
      log('STACK: $stack');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order Failed'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // =========================
  // Build
  // =========================

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

      body: SafeArea(
        child: Padding(
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

                // =========================
                // Order Summary
                // =========================

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

                // =========================
                // Payment Method
                // =========================

                const CustomText(
                  text: 'Payment Method',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),

                const Gap(20),

                // =========================
                // Cash
                // =========================

                ListTile(
                  onTap: () {
                    setState(() {
                      selectedMethod = 'cash';
                    });
                  },

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),

                  contentPadding:
                  const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),

                  tileColor:
                  const Color(0xff3C2F2F),

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
                // Debit Card
                // =========================

                ListTile(
                  onTap: () {
                    setState(() {
                      selectedMethod = 'dept';
                    });
                  },

                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12),
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
                    text: 'Debit card',
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
                    value: 'dept',
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

                // =========================
                // Save Card
                // =========================

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
      ),

      // =========================
      // Bottom Payment Bar
      // =========================

      bottomSheet: Container(
        height: 120,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withAlpha(12),

              blurRadius: 20,

              spreadRadius: 2,

              offset:
              const Offset(0, -4),
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
                    fontWeight:
                    FontWeight.w600,
                  ),

                  CustomText(
                    text: total,
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ],
              ),

              // =========================
              // Pay Button
              // =========================

              LoadingButton(
                height: 50,
                width: 150,

                text: 'Pay Now',

                isLoading: isLoading,

                backgroundColor:
                ColorPalette.primaryColor,

                onPressed: handlePayment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/checkout/data/model/order_item_model.dart';
import 'package:hungry/features/checkout/data/model/order_model.dart';
import 'package:hungry/features/checkout/data/repo/order_repo.dart';
import 'package:hungry/features/checkout/view/widget/order_details_widget.dart';
import 'package:hungry/shared/custom_btn.dart';
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

  Future<void> handlePayment() async {
    if (isLoading) return;

    if (selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select payment method")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final items = widget.cartItems.map((item) {
        return OrderItemModel(
          productId: item.productId,
          quantity: item.quantity,
          spicy: item.spicy,
          optionsByType: (item.optionsByType ?? {}).map(
                (key, value) => MapEntry(
              key,
              value.map((e) => e).toList(),
            ),
          ),
        );
      }).toList();

      final order = OrderModel(
        items: items,
        total: double.parse(widget.totalPrice),
      );

      log("ORDER JSON BEFORE SEND: ${order.toJson()}");

      final result = await orderRepo.saveOrder(order);

      if (result != null) {
        widget.onCartCleared?.call();

        _showSuccessDialog();
      } else {
        throw ApiError(message: 'Order failed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order Failed")),
      );
    }

    setState(() => isLoading = false);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: ColorPalette.primaryColor,
                    child: const Icon(Icons.check, size: 50, color: Colors.white),
                  ),
                  const Gap(10),
                  CustomText(
                    text: 'Success !',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: ColorPalette.primaryColor,
                  ),
                  const Gap(10),
                  const CustomText(
                    text: 'Your payment was successful.\nA receipt for this purchase\nhas been sent to your email.',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFFBCBBBB),
                  ),
                  const Gap(30),
                  CustomBtn(
                    heightSize: 50,
                    widthSize: 220,
                    backgroundColor: ColorPalette.primaryColor.withOpacity(0.2),
                    onTap: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // return to previous screen
                    },
                    child: CustomText(
                      text: 'Close',
                      color: ColorPalette.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = (double.parse(widget.totalPrice) + 0.3 + 0.2).toStringAsFixed(2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorPalette.primaryColor, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Order Summary',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                OrderDetailsWidget(
                  order: widget.totalPrice,
                  taxes: '0.3',
                  fees: '0.2',
                  total: total,
                ),
                const Gap(20),
                const CustomText(
                  text: 'Payment Method',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                const Gap(20),

                // Cash
                ListTile(
                  onTap: () => setState(() => selectedMethod = 'cash'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  tileColor: const Color(0xff3C2F2F),
                  leading: Image.asset(AssetsPath.dollar, width: 50),
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
                    onChanged: (v) => setState(() => selectedMethod = v),
                  ),
                ),

                const Gap(12),

                // Debit Card
                ListTile(
                  onTap: () => setState(() => selectedMethod = 'dept'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  tileColor: Colors.blue.shade900,
                  leading: Image.asset(AssetsPath.Asset, width: 50),
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
                    onChanged: (v) => setState(() => selectedMethod = v),
                  ),
                ),

                const Gap(10),

                Row(
                  children: const [
                    Icon(Icons.check_box, color: Colors.red),
                    Gap(10),
                    CustomText(text: 'Save card details for future payments'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
              LoadingButton(
                height: 50,
                width: 150,
                text: "Pay Now",
                isLoading: isLoading,
                backgroundColor: ColorPalette.primaryColor,
                onPressed: handlePayment,
              )
            ],
          ),
        ),
      ),
    );
  }
}

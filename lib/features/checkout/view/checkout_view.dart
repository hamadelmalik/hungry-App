import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/checkout/view/widget/order_details_widget.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  final String totalPrice;
  const CheckoutView({super.key, required this.totalPrice});



  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? selectedMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        toolbarHeight: 60,
        // أقل من 0 مش ممكن
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Order Summary',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,

                ),
                OrderDetailsWidget(
                  order: widget.totalPrice,
                  taxes: '0.3',
                  fees: '0.2',
                  total: (double.parse(widget.totalPrice.toString())
                      + double.parse('0.3')
                      + double.parse('0.2')).toString(),




                ),

                Gap(20),
                CustomText(
                  text: 'Payment Method',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                Gap(20),
                //---------cash-------------//
                ListTile(
                  onTap: () {
                    setState(() {
                      selectedMethod = 'cash';
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),

                  tileColor: Color(0xff3C2F2F),
                  leading: Image.asset(AssetsPath.dollar, width: 50),
                  title: const CustomText(
                    text: 'Cash on Delivery',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight:FontWeight.bold,
                  ),
                  trailing: Radio<String>(
                    value: 'cash',
                    groupValue: selectedMethod,
                    activeColor: Colors.white, // لون عند الاختيار
                    onChanged: (v) {
                      setState(() {
                        selectedMethod = v!;
                      });
                    },
                  ),
                ),
                Gap(12),
                //-------------dept-----------------------//
                ListTile(
                  onTap: () {
                    setState(() {
                      selectedMethod = 'dept';
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),

                  tileColor: Colors.blue.shade900,
                  leading: Image.asset(AssetsPath.Asset, width: 50),
                  title: const CustomText(
                    text: 'Debit card',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight:FontWeight.bold,

                  ),
                  subtitle: const CustomText(
                    text: '******2345',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  trailing: Radio<String>(
                    value: 'dept',
                    groupValue: selectedMethod,
                    activeColor: Colors.white, // لون عند الاختيار
                    onChanged: (v) {
                      setState(() {
                        selectedMethod = v!;
                      });
                    },
                  ),
                ),

                Gap(10),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
              offset: Offset(0, -4), // ظل لفوق (مناسب للـ bottomSheet)
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Total',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),

                  CustomText(
                    text: (double.parse(widget.totalPrice.toString())
                        + double.parse('0.3')
                        + double.parse('0.2')).toString(),
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              CustomBtn(
                heightSize: 50,
                widthSize: 150,
                backgroundColor: ColorPalette.primaryColor,
                child: CustomText(
                  text: 'Pay Now',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 100,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(20),

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
                                  child: Icon(
                                    Icons.check,
                                    size: 50,
                                    weight: 700, // مدعوم
                                    color: Colors.white,
                                  ),
                                ),
                                Gap(10),
                                CustomText(
                                  text: 'Success !',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: ColorPalette.primaryColor,
                                ),
                                Gap(10),
                                CustomText(
                                  text:
                                      'Your payment was successful.\n A receipt for this purchase\n has been sent to your email. !',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFFBCBBBB),
                                ),
                                Gap(100),
                                CustomBtn(
                                  heightSize: 50,
                                  widthSize: 220,
                                  backgroundColor: ColorPalette.primaryColor
                                      .withValues(alpha: 0.20),
                                  onTap: () {
                                    Navigator.pop(context);
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

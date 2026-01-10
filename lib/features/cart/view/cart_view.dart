import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/features/cart/view/widget/cart_item.dart';
import 'package:hungry/features/checkout/view/checkout_view.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_text.dart';
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  List<int> quantities = List.filled(5, 1);
  void onAdd(int index){
    setState(() {
      quantities[index]++;
    });
  }
  void onMin(int index){
    setState(() {
      if (quantities[index] > 1) quantities[index]--;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 0,
           scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: quantities.length,
                    itemBuilder: (context, index) {
                      return CustomCartItem(
                        image: AssetsPath.hamburger,
                        text: 'Hamburger',
                        desc: 'Veggie Burger',
                        number: quantities[index],
                          onAdd: () => onAdd(index),
                          onMinus: () => onMin(index),
                        onRemove: () {
                          log('Remove item');
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: '\$99.19',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),

                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 45,
                          width: 120,
                          child: CustomBtn(
                            heightSize: 45,
                            widthSize: double.infinity,
                            backgroundColor: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const CheckoutView()),
                              );
                            },
                            child: const CustomText(
                              text: 'Check out',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(20),
              ],

            ),
          ),
        )
    );
  }}





import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/cart/view/widget/cart_item.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
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

              Row(
                children: [
                  CustomText(
                    text: '\$99.19',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  CustomBtn(
                    heightSize: 70,
                    widthSize: 200,
                    backgroundColor: ColorPalette.primaryColor,
                    onTap: () {
                      log('Checkout');
                    },
                    child: CustomText(
                      text: 'Checkout',
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),)
    );
  }}





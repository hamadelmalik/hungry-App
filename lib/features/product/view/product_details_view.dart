import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/product/view/widget/ingredient_card.dart';
import 'package:hungry/features/product/view/widget/spicy_slider.dart';
import 'package:hungry/shared/custom_brn.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double spicyValue = 0.5;
  final ingredients = [
    {'image': AssetsPath.tomato, 'title': 'Tomato'},
    {'image': AssetsPath.chease, 'title': 'Cheese'},
    {'image': AssetsPath.onn, 'title': 'Bacons'},
    {'image': AssetsPath.pickles, 'title': 'pickles'},
  ];
  final sideOptions = [
    {'image': AssetsPath.frise, 'title': 'Frise'},
    {'image': AssetsPath.Coleslaw, 'title': 'Coleslaw'},
    {'image': AssetsPath.salaq, 'title': 'Salad'},
    {'image': AssetsPath.Onion, 'title': 'Onion'},
  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: ColorPalette.primaryColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),         child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpicySlider(
                  value: spicyValue,
                  onChanged: (v) {
                    setState(() {
                      spicyValue = v;
                    });
                  },
                ),
                Gap(10),
                CustomText(
                  text: 'Toppings',
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                Gap(20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      ingredients.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        // مسافة بين كل كارت واللي بعده
                        child: IngredientCard(
                          image: ingredients[index]['image']!,
                          title: ingredients[index]['title']!,
                          colorIcn: Colors.white,
                          boxDecoration: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(20),
                CustomText(
                  text: 'Side options',
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                Gap(20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      sideOptions.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        // مسافة بين كل كارت واللي بعده
                        child: IngredientCard(
                          image: sideOptions[index]['image']!,
                          title: sideOptions[index]['title']!,
                          colorIcn: Colors.white,
                          boxDecoration: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(30),
                CustomText(
                  text: 'Total',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
                    CustomText(
                      text: '\$18.19',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    CustomBtn(
                      heightSize: 70,
                      widthSize: 200,
                      backgroundColor: ColorPalette.primaryColor,
                      onTap: () {
                        log('Added to cart');
                      },
                      child: CustomText(
                        text: 'Add To Cart',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

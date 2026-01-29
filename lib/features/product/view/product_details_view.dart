
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';
import 'package:hungry/features/home/data/repo/prodect_repo.dart';
import 'package:hungry/features/product/view/widget/custom_bottom.dart';
import 'package:hungry/features/product/view/widget/ingredient_card.dart';
import 'package:hungry/features/product/view/widget/spicy_slider.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  final String productImage;
  final int productId;

  const ProductDetailsView({
    super.key,
    required this.productImage,
    required this.productId,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double spicyValue = 0.5;
  bool isLoading=false;

  List<int> selectedTopping = [];
  List<int> selectedOptions = [];

  ProductRepo productRepo = ProductRepo();
  List<ToppingModel>? toppings;
  List<ToppingModel>? options;

  Future<void> getToppings() async {
  try{
    final res = await productRepo.getTopping();
    setState(() => toppings = res);
//    selectedTopping = [];
  }catch (e){
    throw ApiError(message: e.toString());
  }

  }

  //-----options-----

  Future<void> getOption() async {
    final res = await productRepo.getOption();
    setState(() {
      options = res;
     // selectedOptions = [];
    });
  }

  //----------cart----------------

  CartRepo cartRepo = CartRepo();

  @override
  void initState() {
    getToppings();
    getOption();
    super.initState();
  }

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
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpicySlider(
                  img: widget.productImage,
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
                //------------topping----------
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(toppings?.length ?? 4, (index) {
                        // final isSelected = selectedOptions == index;
                      final topping = toppings?[index];
                      final id = topping?.id ?? 1;

                      if (topping == null) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: CupertinoActivityIndicator(),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        //----------topping ------------------
                        child: ToppingsCard(
                          image: topping.image,
                          title: topping.name,
                          colorIcn: Colors.white,
                          boxDecoration: Colors.red,
                          onAdd: () {
                            setState(() {
                              if (selectedTopping.contains(id)) {
                                selectedTopping.remove(id);
                              } else {
                                selectedTopping.add(id);
                              }
                            });
                          },
                          // colorIcn: isSelected ? Colors.red : Colors.white,
                        ),
                      );
                    }),
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
                //-----------//----------options-------------//
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(options?.length ?? 4, (index) {
                      //    final isSelected = selectedToppingIndex == index;
                      final option = options?[index];
                      final id = option?.id ?? 1;

                      if (option == null) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      //----------options-------------
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ToppingsCard(
                          image: option.image,
                          title: option.name,
                          colorIcn: Colors.white,
                          boxDecoration: Colors.grey,
                          onAdd: () {
                            setState(() {
                              if (selectedOptions.contains(id)) {
                                selectedOptions.remove(id);
                              } else {
                                selectedOptions.add(id);
                              }
                            });
                          },
                          // colorIcn: isSelected ? Colors.red : Colors.white,
                        ),
                      );
                    }),
                  ),
                ),
                Gap(200),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorPalette.primaryColor.withValues(alpha: 0.7),
                ColorPalette.primaryColor,
                ColorPalette.primaryColor,
                ColorPalette.primaryColor,
                ColorPalette.primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Burger Price :',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: '\$ 18.9',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                CustomButton(
                  widget: isLoading ? CupertinoActivityIndicator(color: Colors.white,):Icon(CupertinoIcons.cart_badge_plus),
                  gap: 10,
                  height: 48,
                  color: Colors.white,
                  textColor: ColorPalette.primaryColor,
                  text: 'Add To Cart',

                  onTap: () async {
                    final cartItems1 = CartModel(
                      productId: 1,
                      quantity: 2,
                      spicy: 0.1,
                      toppings: [1,2,3],
                      options: [1,2,3],
                    );

                    final cartItems2 = CartModel(
                      productId: 3,
                      quantity: 1,
                      spicy: 0.0, // لو مفيش spicy
                      toppings: [],
                      options: [],
                    );
                    final cartRequest = CartRequestModel(items: [cartItems1, cartItems2]);
                    log('Cart JSON: ${cartRequest.toJson()}');
                    await cartRepo.addToCart(
                      CartRequestModel(items: [cartItems1, cartItems2]),
                    );


                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

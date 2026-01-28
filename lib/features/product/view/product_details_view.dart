import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/cart/data/model/model.dart';
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

  List<int> selectedToppingIndex = [];
  List<int> selectedOptionIndex = [];

  ProductRepo productRepo = ProductRepo();
  List<ToppingModel>? toppings;
  List<ToppingModel>? options;

  Future<void> getToppings() async {
    final res = await productRepo.getTopping();
    setState(() => toppings = res);
  }

  //-----options-----

  Future<void> getOption() async {
    final res = await productRepo.getOption();
    setState(() {
      options = res;
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
                      //    final isSelected = selectedToppingIndex == index;
                      final topping = toppings?[index];

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
                            final id =topping.id;
                            setState(() {
                              if(selectedToppingIndex.contains(id)){
                                selectedToppingIndex.removeAt(id);
                              }else{
                                selectedToppingIndex.add(id);
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
                            final id = option.id;
                            setState(() {
                              if (selectedOptionIndex.contains(id)) {
                                selectedOptionIndex.removeAt(id);
                              } else {
                                selectedOptionIndex.add(id);
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
                  widget: Icon(CupertinoIcons.cart_badge_plus),
                  gap: 10,
                  height: 48,
                  color: Colors.white,
                  textColor: ColorPalette.primaryColor,
                  text: 'Add To Cart',
                  onTap: () {
                    final cartItems = CartModel(
                      productId: widget.productId,
                      qyt: 1,
                      spicy: spicyValue,
                      toppings: selectedToppingIndex,
                      options: selectedOptionIndex,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

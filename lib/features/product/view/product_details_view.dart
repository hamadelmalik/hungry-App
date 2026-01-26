import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';
import 'package:hungry/features/home/data/repo/prodect_repo.dart';
import 'package:hungry/features/product/view/widget/ingredient_card.dart';
import 'package:hungry/features/product/view/widget/spicy_slider.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double spicyValue = 0.5;



  ProductRepo productRepo=ProductRepo();
  List<ToppingModel>? toppings;
  List<ToppingModel>? options;
  Future<void>getToppings()async{
    final res=await productRepo.getTopping();
    setState(() =>toppings=res);

  }

  //-----sideoptions-----



  Future<void>getOption()async{
    final res=await productRepo.getOption();
   setState(() {
     options=res;
   });

  }


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
                //------------topping----------
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      toppings?.length ?? 4,
                          (index) {
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
                          child: ToppingsCard(
                            image: topping.image,
                            title: topping.name,
                            colorIcn: Colors.white, boxDecoration: Colors.red,
                           // colorIcn: isSelected ? Colors.red : Colors.white,
                          ),
                        );
                      },
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
                      options?.length ?? 4,
                          (index) {
                        //    final isSelected = selectedToppingIndex == index;
                        final option = options?[index];

                        if (option == null) {
                          return const Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: CupertinoActivityIndicator(),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ToppingsCard(
                            image: option.image,
                            title: option.name,
                            colorIcn: Colors.white, boxDecoration: Colors.grey,
                            // colorIcn: isSelected ? Colors.red : Colors.white,
                          ),
                        );
                      },
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

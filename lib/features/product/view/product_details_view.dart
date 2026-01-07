
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/product/view/widget/ingredient_card.dart';
import 'package:hungry/features/product/view/widget/spicy_slider.dart';
import 'package:hungry/shared/custom_text.dart';
class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final ingredients = [
    {'image': AssetsPath.tomato, 'title': 'Tomato'},
    {'image': AssetsPath.chease, 'title': 'Cheese'},
    {'image': AssetsPath.onn, 'title': 'Bacons'},
    {'image': AssetsPath.pickles, 'title': 'pickles'},
  ];
  @override
  Widget build(BuildContext context) {
    double spicyValue = 0.5;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: ColorPalette.primaryColor,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
            CustomText(text: 'Toppings',fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold,),
            Gap(20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  ingredients.length,
                      (index) => Padding(
                    padding: const EdgeInsets.only(right: 12), // مسافة بين كل كارت واللي بعده
                    child: IngredientCard(
                      image: ingredients[index]['image']!,
                      title: ingredients[index]['title']!,
                    ),
                  ),
                ),
              ),
            ),


          ],
        )
      ),
    );
  }
}

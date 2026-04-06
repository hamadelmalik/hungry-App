import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/home/data/model/option_model.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';
import 'package:hungry/features/product/data/product_repo.dart';
import 'package:hungry/features/product/view/widget/custom_bottom.dart';
import 'package:hungry/features/product/view/widget/ingredient_card.dart';
import 'package:hungry/features/product/view/widget/spicy_slider.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  final String productImage, productPrice;
  final int productId;

  const ProductDetailsView({
    super.key,
    required this.productImage,
    required this.productId,
    required this.productPrice,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double spicyValue = 0.5;
  bool isLoading = false;
  bool isOptionsLoading = false;

  ProductRepo productRepo = ProductRepo();
  CartRepo cartRepo = CartRepo();
  OptionRepo optionRepo = OptionRepo();
  OptionModel? selectedOption;
  // ✅ Map لتخزين كل الخيارات حسب النوع
  Map<String, List<OptionModel>> optionsByType = {};

  @override
  void initState() {
    super.initState();
    fetchOptions();
  }

  Future<void> fetchOptions() async {
    setState(() => isOptionsLoading = true);
    try {
      final response = await optionRepo.getOptionsResponse();

      setState(() => optionsByType = response);

    } catch (e) {
      log('❌ Failed to load options: $e');
    } finally {
      setState(() => isOptionsLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
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
                    setState(() => spicyValue = v);
                  },
                ),
                Gap(20),

                // ✅ Loop ديناميكي لكل نوع
                if (isOptionsLoading)
                  const Center(child: CupertinoActivityIndicator())
                else
                  ...optionsByType.entries.map((entry) {
                    final typeName = entry.key; // مثلا "toppings" أو "side_options"
                    final list = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        CustomText(
                          text: typeName.replaceAll('_', ' ').toUpperCase(),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: list.map((option) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ProductOptionCart(
                                  image: option.image,
                                  title: option.name,
                                  colorIcn: Colors.white,
                                  boxDecoration: Colors.grey,
                                  onAdd: () {
                                    // هنا ممكن تضيف الاختيارات للمتحولات
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }),

                Gap(200),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: 100,
          decoration: BoxDecoration(


            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Burger Price :',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: "\$${widget.productPrice}",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                CustomButton(
                  widget: isLoading
                      ? const CupertinoActivityIndicator(color: Colors.white)
                      : const Icon(CupertinoIcons.cart_badge_plus),
                  gap: 10,
                  height: 48,
                  color: Colors.white,
                  textColor: ColorPalette.primaryColor,
                  text: 'Add To Cart',
                  onTap: () async {
                    setState(() => isLoading = true);
                    try {
                      final cartItem = CartModel(
                        productId: widget.productId,
                        quantity: 1,
                        spicy: spicyValue,
                        optionTypeId: selectedOption?.typeId,
                        optionId: selectedOption?.id,
                      );
                      await cartRepo.addToCart(CartRequestModel(items: [cartItem]));
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add to cart successfully')),

                      );
                    } catch (e) {
                      log('❌ Add to cart error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error in add to cart')),
                      );
                    } finally {
                      setState(() => isLoading = false);
                    }
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/home/view/widget/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductBottomSheet extends StatelessWidget {
  final String productPrice;
  final bool isLoading;
  final VoidCallback onTap;

  const ProductBottomSheet({
    super.key,
    required this.productPrice,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: ColorPalette.darkMocha,
        borderRadius: BorderRadius.only(
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
                  text: 'Total Price :',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.aje,
                ),
                CustomText(
                  text: "\$$productPrice",
                  fontSize: 18,
                  color: ColorPalette.aje,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            CustomButton(
              widget: isLoading
                  ? const CupertinoActivityIndicator(color: Colors.white)
                  : const Icon(CupertinoIcons.cart_badge_plus),
              gap: 20,
              height: 48,
              color: Colors.white,
              textColor: ColorPalette.primaryColor,
              text: 'Add To Cart',
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
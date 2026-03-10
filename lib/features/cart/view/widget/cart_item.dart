import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomCartItem extends StatelessWidget {
  final String image, text, desc;
  final VoidCallback? onAdd;
  final VoidCallback? onMinus;
  final VoidCallback? onRemove;
  final int number;

  const CustomCartItem({
    super.key,
    required this.image,
    required this.text,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    required this.desc,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'http://192.168.1.19:8000/storage/uploadimages/$image',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  CustomText(text: text, fontWeight: FontWeight.bold),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        radius: 18,
                        // نصف القطر
                        backgroundColor: ColorPalette.primaryColor,
                        // 👈 لون الخلفية
                        child: Icon(CupertinoIcons.add, color: Colors.white),
                      ),
                    ),
                    Gap(10),
                    CustomText(
                      text: number.toString(),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    Gap(10),

                    GestureDetector(
                      onTap: onMinus,
                      child: CircleAvatar(
                        radius: 18,
                        // نصف القطر
                        backgroundColor: ColorPalette.primaryColor,
                        // 👈 لون الخلفية
                        child: Icon(CupertinoIcons.minus, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                CustomBtn(
                  heightSize: 44,
                  widthSize: 145,
                  backgroundColor: ColorPalette.primaryColor,
                  onTap: onRemove,
                  child: CustomText(
                    text: 'Remove',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

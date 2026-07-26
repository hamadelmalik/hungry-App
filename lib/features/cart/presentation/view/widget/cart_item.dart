import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/api_constants.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// الصورة + الاسم
            Row(
              children: [
                Image.network(
                  '${ApiConstants.storageUrl}/uploadimages/$image',                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),

                /// الاسم
                Expanded(
                  child: CustomText(
                    text: text,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    //maxLines: 2,
                  ),
                ),
              ],
            ),

            const Gap(10),

            /// الازرار
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// + و -
                Row(
                  children: [
                    GestureDetector(
                      onTap: onMinus,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: ColorPalette.primaryColor,
                        child: const Icon(CupertinoIcons.minus,
                            color: Colors.white),
                      ),
                    ),

                    const Gap(10),

                    CustomText(
                      text: number.toString(),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),

                    const Gap(10),

                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: ColorPalette.primaryColor,
                        child:
                        const Icon(CupertinoIcons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                /// زر Remove
                CustomBtn(
                  heightSize: 40,
                  widthSize: 110,
                  backgroundColor: ColorPalette.primaryColor,
                  onTap: onRemove,
                  child: const CustomText(
                    text: 'Remove',
                    color: Colors.white,
                    fontSize: 14,
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
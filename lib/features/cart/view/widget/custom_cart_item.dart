import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_text.dart';
class CustomCartItemNew extends StatelessWidget {
  final String image, text, desc;
  final VoidCallback? onAdd;
  final VoidCallback? onMinus;
  final VoidCallback? onRemove;
  final int number;
  final List<dynamic>? sideOptions;

  const CustomCartItemNew({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.number,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    this.sideOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الاسم فوق الكارت
            CustomText(
              text: text,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(10),

            // Side options إذا موجودة
            if (sideOptions != null && sideOptions!.isNotEmpty) ...[
              const CustomText(
                text: "Side Options:",
                fontWeight: FontWeight.bold,
              ),
              const Gap(5),
              Wrap(
                spacing: 10,
                children: sideOptions!.map((s) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(s['image'], width: 40, height: 40),
                      SizedBox(
                        width: 70,
                        child: CustomText(
                          text: s['name'],
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const Gap(10),
            ],

            // Row للصورة + أزرار الإضافة/النقصان والعدد
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  "http://192.168.1.19:8000/storage/$image",
                  width:90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) {
                    //print("IMAGE ERROR => $error");
                    return Icon(Icons.error, size: 30);
                  },
                ),


                Row(
                  children: [
                    GestureDetector(
                      onTap: onMinus,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: ColorPalette.primaryColor,
                        child: const Icon(CupertinoIcons.minus,
                            color: Colors.white),
                      ),
                    ),
                    const Gap(10),
                    CustomText(
                      text: number.toString(),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: ColorPalette.primaryColor,
                        child: const Icon(CupertinoIcons.add,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Gap(15),
            // زر Remove تحت كل شيء
            CustomBtn(
              heightSize: 44,
              widthSize: double.infinity,
              backgroundColor: ColorPalette.primaryColor,
              onTap: onRemove,
              child: const CustomText(
                text: 'Remove',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
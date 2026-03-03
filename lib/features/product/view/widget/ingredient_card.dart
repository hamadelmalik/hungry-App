import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductOptionCart extends StatelessWidget {
  final String image, title;
  final Color colorIcn, boxDecoration;
  final VoidCallback onAdd;

  const ProductOptionCart({
    super.key,
    required this.image,
    required this.title,
    required this.colorIcn,
    required this.boxDecoration, required this.onAdd,

  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28), // 👈 قصّ الكارد
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: const Color(0xFF3B2F2F),
          border: Border.all(color: ColorPalette.primaryColor),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Image.network(
                "http://192.168.1.19:8000/storage/$image",
                height: 70,
                fit: BoxFit.contain,
              ),
            ),

            // الجزء السفلي
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: title,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: boxDecoration,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: colorIcn, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

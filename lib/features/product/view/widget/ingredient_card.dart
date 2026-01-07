import 'package:flutter/material.dart';
import 'package:hungry/shared/custom_text.dart';
class IngredientCard extends StatelessWidget {
  final String image,title;
  const IngredientCard({super.key,required this.image,required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28), // 👈 قصّ الكارد
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: const Color(0xFF3B2F2F),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
        BoxShadow(
        color: Colors.black.withValues(alpha: 0.18),
        blurRadius: 24,
        spreadRadius: 0,
        offset: const Offset(0, 12),
      ),
      ],
        ),
        child: Column(
          children: [
            // الجزء الأبيض (جوا الكارد)
             // 👈 بدل margin
               Container(
                 width: 150,
              // padding: const EdgeInsets.only(bottom: 10,right: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Image.asset(
                  image,
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
                    child: CustomText(text: title,fontSize:18,color: Colors.white,)
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
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

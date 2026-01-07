import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';

class FoodHome extends StatefulWidget {
  const FoodHome({
    super.key,
    required this.category,
    required this.selectedIndex,
  });

  final  int selectedIndex;
  final List  category;

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
 late int selectedIndex = 0;

 @override
  void initState() {
    selectedIndex=widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.category.length, (index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index; // ✔️ الصح
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorPalette.primaryColor
                      : ColorPalette.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: CustomText(
                  text: widget.category[index],
                  color: isSelected
                      ? Colors.white
                      : ColorPalette.primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

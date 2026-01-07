
import 'package:flutter/material.dart';

class SplitColorIcon extends StatelessWidget {
  final double size;
  final Color topColor;
  final Color bottomColor;
  final double borderRadius;
  final List<BoxShadow> shadow;

  const SplitColorIcon({
    super.key,
    this.size = 100.0,
    this.topColor = Colors.white,
    this.bottomColor = const Color(0xFF4E342E), // Dark brown
    this.borderRadius = 12.0,
    this.shadow = const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(2, 2),
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadow,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: topColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius),
                ),
              ),

            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: bottomColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(borderRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
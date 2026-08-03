import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/route/data/menu_items_model.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<MenuItemModel> menuItems;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.92,
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          decoration: BoxDecoration(
            color: ColorPalette.primaryColor.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              menuItems.length,
                  (index) => _navItem(
                icon: getIcon(menuItems[index].icon),
                index: index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required int index,
  }) {
    final bool isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            padding: EdgeInsets.all(isSelected ? 10 : 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.yellow.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 250),
              child: Icon(
                icon,
                size: isSelected ? 28 : 24,
                color: isSelected ? Colors.yellow : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData getIcon(String icon) {
    switch (icon.toLowerCase()) {
      case 'home':
        return CupertinoIcons.home;

      case 'cart':
        return CupertinoIcons.cart;

      case 'restaurant':
      case 'orders':
        return Icons.restaurant;

      case 'profile':
        return CupertinoIcons.profile_circled;

      default:
        return Icons.help_outline;
    }
  }
}
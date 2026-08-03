import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'custom_text.dart';



SnackBar customSnack(
    String errorMsg, {
      Color? color,//color selected
      IconData? iconData,
    }) {
  return SnackBar(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    backgroundColor: color ?? Colors.red.shade900, // اللون الافتراضي أحمر
    content: FittedBox(
      child: Row(
        children: [
          Icon(
              iconData ?? CupertinoIcons.info, color: Colors.white),
          const Gap(14),
          CustomText(
            text: errorMsg,
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    ),
  );
}

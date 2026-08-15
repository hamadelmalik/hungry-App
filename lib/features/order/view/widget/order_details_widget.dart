import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';
class OrderDetailsWidget extends StatelessWidget {
  final String order,taxes,fees,total;
  const OrderDetailsWidget({super.key, required this.order, required this.taxes, required this.fees, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      checkoutWidget('order',order,false),
      Gap(10),
      checkoutWidget('taxes', taxes,false),
      Gap(10),
      checkoutWidget('Delivery fees', fees,false),
      Divider(),
      checkoutWidget('Total', total,true),
      Gap(10),
      checkoutWidget('Estimated delivery time', '15-30',true),

    ],);
  }
}

Widget checkoutWidget(
    String title,
    String price,
    bool isBold,
    ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        color: isBold
            ? Colors.black
            : ColorPalette.textColor,
        fontSize: 15,
        fontWeight: isBold
            ? FontWeight.bold
            : FontWeight.w400,
      ),

      CustomText(
        text: '$price\$',
        color: isBold
            ? Colors.black
            : ColorPalette.textColor,
        fontSize: 15,
        fontWeight: isBold
            ? FontWeight.bold
            : FontWeight.w400,
      ),
    ],
  );
}


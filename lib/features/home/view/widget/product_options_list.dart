import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/home/data/model/option_model.dart';
import 'package:hungry/features/home/view/product_option_card.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductOptionsList extends StatelessWidget {

  final bool isLoading;
  final Map<String, List<OptionModel>> optionsByType;

  const ProductOptionsList({
    super.key,
    required this.isLoading,
    required this.optionsByType,
  });


  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }


    return Column(
      children: optionsByType.entries.map((entry) {

        final typeName = entry.key; // toppings, side_options
        final list = entry.value;


        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Gap(20),

            CustomText(
              text: typeName.replaceAll('_', ' ').toUpperCase(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),

            const Gap(10),


            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: list.map((option) {

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),

                    child: ProductOptionCart(
                      image: option.image,
                      title: option.name,
                      colorIcn: Colors.white,
                      boxDecoration: Colors.grey,

                      onAdd: () {
                        // action later
                      },
                    ),

                  );

                }).toList(),
              ),
            ),
          ],
        );

      }).toList(),
    );
  }
}
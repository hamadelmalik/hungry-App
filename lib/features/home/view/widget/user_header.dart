import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    super.key,
    required this.userName,
    required this.userImage,
  });

  final String userName, userImage;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: 'Hello,',
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
                CustomText(
                  text: userName,
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: ColorPalette.primaryColor,
                ),
              ],
            ),

            CustomText(
              text: 'Real Burger & Pizza',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.network(
              userImage,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
        ),
      ],
    );
  }
}

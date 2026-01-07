import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/home/view/widget/card_item.dart';
import 'package:hungry/shared/custom_text.dart';

class HomeVieww extends StatefulWidget {
  const HomeVieww({super.key});

  @override
  State<HomeVieww> createState() => _HomeViewwState();
}

class _HomeViewwState extends State<HomeVieww> {
  List category = ['All', 'Combos', 'Sliders', 'Classic'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      //    mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AssetsPath.hungryTex,
                          width: 150,
                          colorFilter: ColorFilter.mode(
                            ColorPalette.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(20),

                        //   CustomText(text: "Hello, Rich Sonic"),
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(radius: 30),
                  ],
                ),
                Gap(10),
                Material(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hint: Text('Search...........'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(strokeAlign: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(strokeAlign: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Gap(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(category.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? ColorPalette.primaryColor
                                  : ColorPalette.secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            child: CustomText(
                              text: category[index],
                              color: selectedIndex == index
                                  ? Colors.white
                                  : ColorPalette.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Gap(10),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 2,

                  ),
                  itemBuilder: (context, index) {
                    return CardItem(
                      text: 'Cheeseburger',
                      desc: 'Burger Wendys',
                      image: AssetsPath.b1,
                      rate: '✨4.9',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

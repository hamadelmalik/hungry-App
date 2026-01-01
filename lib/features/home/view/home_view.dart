import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/shared/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combos', 'Sliders', 'Classic'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
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
              TextField(
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
              Gap(10),
              SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                    List.generate(category.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorPalette.secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          child: CustomText(
                            text: category[index],
                            color: ColorPalette.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

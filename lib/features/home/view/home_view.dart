import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/assets_app.dart';
import 'package:hungry/features/home/view/widget/card_item.dart';
import 'package:hungry/features/home/view/widget/catogery_home.dart';
import 'package:hungry/features/home/view/widget/search_widget.dart';
import 'package:hungry/features/home/view/widget/user_header.dart';
import 'package:hungry/features/product/view/product_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
        child: CustomScrollView(
          slivers: [
            //------------header-------------------
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              floating: false,
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 38, right:20,left: 20),
                  child: Column(
                    children: [
                      UserHeader(),
                      Gap(10),
                       SearchWidget(),

                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: FoodHome(category: category, selectedIndex: selectedIndex),
            ), ),
            //---------gridView-------------//
            SliverPadding(padding: EdgeInsets.symmetric(horizontal: 30)),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                      childCount: 6,
                      (context, index) {
                return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:  (context) {
                        return ProductDetailsView();
                      },));
                    },
                    child: CardItem(text: 'burgger', desc: 'burgger wenday', image: AssetsPath.b1, rate: '4.9'));
              }),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

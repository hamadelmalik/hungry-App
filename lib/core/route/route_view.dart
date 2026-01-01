import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/auth/view/profile_view.dart';
import 'package:hungry/features/card/view/cart_view.dart';
import 'package:hungry/features/home/view/home_view.dart';
import 'package:hungry/features/orderHistory/view/order_history_view.dart';

class PageViewRoute extends StatefulWidget {
  const PageViewRoute({super.key});

  @override
  State<PageViewRoute> createState() => _PageViewRouteState();
}

class _PageViewRouteState extends State<PageViewRoute> {
  late PageController pageController;

  int currentPage = 0;

  late List<Widget> pageList;

  @override
  void initState() {
    pageList = [
      HomeView(),
      CartView(),
      OrderHistoryView(),
      ProfileView(),
    ];
    pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: pageController, children: pageList),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorPalette.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
            pageController.jumpToPage(currentPage);
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home, color: Colors.white),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart, color: Colors.white),
              label: 'Cart',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant, color: Colors.white),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled, color: Colors.white),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}

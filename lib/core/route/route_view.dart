import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/auth/view/profile_view.dart';
import 'package:hungry/features/cart/view/cart_view.dart';
import 'package:hungry/features/home/view/home_view.dart';
import 'package:hungry/features/orderHistory/view/order_history_view.dart';

class PageRouteView extends StatefulWidget {
  const PageRouteView({super.key});

  @override
  State<PageRouteView> createState() => _PageViewRouteState();
}

class _PageViewRouteState extends State<PageRouteView> {
  late PageController pageController;

  int currentPage = 0;

  late List<Widget> pageList;

  @override
  void initState() {
    pageList = [HomeView(), CartView(), OrderHistoryView(), ProfileView()];
    pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pageList,
      ),

      bottomNavigationBar: ClipRRect(

        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: ColorPalette.primaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPage,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
            pageController.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'OrderHistory',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

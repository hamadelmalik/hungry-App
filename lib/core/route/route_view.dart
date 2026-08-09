import 'package:flutter/material.dart';

import 'package:hungry/core/route/data/menu_items_model.dart';
import 'package:hungry/core/route/view/widget/custom_nav_bar.dar.dart';

import 'package:hungry/features/auth/view/profile_view.dart';
import 'package:hungry/features/cart/presentation/view/cart_view.dart';
import 'package:hungry/features/home/view/home_view.dart';
import 'package:hungry/features/order/view/order_history_view.dart';


class PageRouteView extends StatefulWidget {
  const PageRouteView({super.key});

  @override
  State<PageRouteView> createState() => _PageRouteViewState();
}

class _PageRouteViewState extends State<PageRouteView> {

  int currentPage = 0;

  final List<MenuItemModel> menuItems = [
    MenuItemModel(
      id: 1,
      title: 'Home',
      icon: 'home',
      route: '/home',
    ),
    MenuItemModel(
      id: 2,
      title: 'Cart',
      icon: 'cart',
      route: '/cart',
    ),
    MenuItemModel(
      id: 3,
      title: 'Orders',
      icon: 'restaurant',
      route: '/orders',
    ),
    MenuItemModel(
      id: 4,
      title: 'Profile',
      icon: 'profile',
      route: '/profile',
    ),
  ];

  Widget getScreen(String route) {
    switch (route) {

      case '/home':
        return const HomeView();

      case '/cart':
        return const CartView();

      case '/orders':
        return const OrderHistoryView();

      case '/profile':
        return const ProfileView();

      default:
        return const Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,

      body: IndexedStack(
        index: currentPage,

        children: menuItems
            .map((item) => getScreen(item.route))
            .toList(),
      ),

      bottomNavigationBar: SizedBox(
        height: 75,

        child: CustomNavBar(
          currentIndex: currentPage,

          menuItems: menuItems,

          onTap: (index, route) {

            setState(() {
              currentPage = index;
            });

          },
        ),
      ),
    );
  }
}
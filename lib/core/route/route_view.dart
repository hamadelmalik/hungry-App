import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/auth/view/profile_view.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/cart/view/cart_view.dart';
import 'package:hungry/features/home/view/home_view.dart';
import 'package:hungry/features/orderHistory/view/order_history_view.dart';

class PageRouteView extends StatefulWidget {
  const PageRouteView({super.key});

  @override
  State<PageRouteView> createState() => _PageRouteViewState();
}

class _PageRouteViewState extends State<PageRouteView> {
  int currentPage = 0;


  final CartRepo cartRepo=CartRepo();

  bool isCartEmpty = true;

  Future<void> checkCart() async {
    final res = await cartRepo.getCartData();
    setState(() {
      isCartEmpty = res.cartData.items.isEmpty;
    });

  }


  @override
  void initState() {
    super.initState();
    checkCart();
  }
  final List<Widget> _screens = const [
    HomeView(),
    CartView(),
    OrderHistoryView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    if (index == 1 && isCartEmpty) {
      if (isCartEmpty=true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cart is empty")),
        );
        return;
      }
    }


    // هنا بنفتح الصفحة الجديدة باستخدام Navigator
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentPage], // الصفحة الحالية
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorPalette.primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
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
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
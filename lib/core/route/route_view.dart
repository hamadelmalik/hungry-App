import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/route/cubit/menu_cubit.dart';
import 'package:hungry/core/route/cubit/menu_state.dart';
import 'package:hungry/core/route/view/widget/custom_nav_bar.dar.dart';
import 'package:hungry/features/auth/view/profile_view.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
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


  final CartRepo cartRepo = CartRepo();

  bool isCartEmpty = true;

  Future<void> checkCart() async {
    final res = await cartRepo.getCartData();

    if (!mounted) return;

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

  Future<void> _onItemTapped(int index) async {
    if (index == 1) {
      await checkCart();

      if (!mounted) return;

      if (isCartEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cart is empty")),
        );
        return;
      }
    }

    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuStates>(
      builder: (context, state) {
        if (state is MenuLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is MenuError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        }

        if (state is MenuSuccess) {
          final menuItems = state.menuItems;

          return Scaffold(
            extendBody: true,
            body: IndexedStack(
              index: currentPage,
              children: _screens,
            ),
            bottomNavigationBar: SizedBox(
              height: 75,
              child: CustomNavBar(
                currentIndex: currentPage,
                onTap: _onItemTapped,
                menuItems: menuItems,
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
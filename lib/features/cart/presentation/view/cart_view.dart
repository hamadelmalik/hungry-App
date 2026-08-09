import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/auth/repo/Auth/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/repo/profile/profile_repo.dart';
import 'package:hungry/features/auth/view/widget/guest_mode.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_state.dart';
import 'package:hungry/features/cart/presentation/view/widget/cart_empty.dart';
import 'package:hungry/features/cart/presentation/view/widget/cart_item.dart';
import 'package:hungry/features/order/data/model/order_item_model.dart';
import 'package:hungry/features/order/view/checkout_view.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:hungry/shared/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool isGuest = false;
  final apiServices = ApiServices();

  late final profileRepo = ProfileRepo(apiServices: apiServices);

  late final authRepo = AuthRepo(
    apiServices: apiServices,
    profileRepo: profileRepo,
  );

  UserModel? userModel;

  Future<void> getProfileData() async {
    try {
      final user = await profileRepo.getProfileData();
      if (!mounted) return;
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Profile Error';

      if (e is ApiError) {
        throw errorMsg = e.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) {
      setState(() => isGuest = authRepo.isGuest);
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogin();

    context.read<CartCubit>().getCartData();
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (isGuest) {
      return const GuestModeView();
    }

    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        // conditions
      },
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final cartResponse = cubit.cartResponse;

        final bool isCartEmpty =
            cartResponse == null || cartResponse.cartData.items.isEmpty;

        if (isCartEmpty) {
          return const CartEmpty();
        }

        return Scaffold(
          backgroundColor: ColorPalette.aje,

          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F6F7),
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,

            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            title: const Text(
              'Cart',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_horiz, color: Colors.black54),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ...cartResponse.cartData.items.map((item) {
                        final index = cartResponse.cartData.items.indexOf(item);

                        return CustomCartItem(
                          image: item.image,
                          text: item.name,
                          desc: 'xxxx',
                          number: cubit.quantity![index],
                          onAdd: () => cubit.onAdd(index),
                          onMinus: () => cubit.onMinus(index),
                          onRemove: () => cubit.removeCartItem(item.itemId),
                        );
                      }),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: cartResponse.cartData.totalPrice
                                .toStringAsFixed(2),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      CustomBtn(
                        heightSize: 45,
                        widthSize: 120,
                        backgroundColor: ColorPalette.darkMocha,
                        text: 'Check Out',
                        textColor: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutView(
                                totalPrice: cartResponse.cartData.totalPrice
                                    .toStringAsFixed(2),

                                  cartItems: cartResponse.cartData.items.map((item) {
                                    return OrderItemModel(
                                      productId: item.productId,
                                      quantity: item.quantity,
                                      spicy: item.spicy ,
                                      totalPrice: item.totalPrice ,
                                      optionsByType: item.optionsByType ?? {},
                                    );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

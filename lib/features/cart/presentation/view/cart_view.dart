
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/constants/color_palette.dart';
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

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is GetCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnack(state.message),
          );
        }

        if (state is RemoveCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnack(state.message),
          );
        }
      },

      builder: (context, state) {
        final cubit = context.read<CartCubit>();

        if (state is AutoLoginLoading ||
            state is GetCartLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (cubit.isGuest) {
          return const GuestModeView();
        }

        if (state is GetCartError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        }

        final cartResponse = cubit.cartResponse;

        if (cartResponse == null ||
            cartResponse.cartData.items.isEmpty) {
          return const CartEmpty();
        }

        return Scaffold(
          backgroundColor: ColorPalette.aje,

          appBar: AppBar(
            backgroundColor: ColorPalette.aje,
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
                  onPressed: () => Navigator.pop(context),
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
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),

            child: ListView(
              children: [
                ...cartResponse.cartData.items
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return CustomCartItem(
                    image: item.image,
                    text: item.name,
                    desc: 'xxxx',

                    number: cubit.quantity[index],

                    onAdd: () {
                      cubit.onAdd(index);
                    },

                    onMinus: () {
                      cubit.onMinus(index);
                    },

                    onRemove: () {
                      cubit.removeCartItem(item.itemId);
                    },
                  );
                }),

                const SizedBox(height: 15),

                CustomText(
                  text: cartResponse.cartData.totalPrice
                      .toStringAsFixed(2),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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

                final orderItems = cartResponse.cartData.items
                    .map<OrderItemModel>(
                      (item) => OrderItemModel(
                    productId: item.productId,
                    quantity: item.quantity,
                    spicy: item.spicy,
                    totalPrice: item.totalPrice,
                    selectedOptions: item.options,
                  ),
                )
                    .toList();


                debugPrint(orderItems.runtimeType.toString());


                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutView(
                      totalPrice: cartResponse.cartData.totalPrice
                          .toStringAsFixed(2),

                      cartItems: orderItems,
                    ),
                  ),
                );
              },
            ),
              ],
            ),
          ),
        );
      },
    );
  }
}
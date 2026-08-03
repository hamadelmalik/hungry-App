import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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

  bool isGuest=false;
  final apiServices = ApiServices();

  late final profileRepo = ProfileRepo(
    apiServices: apiServices,
  );

  late final authRepo = AuthRepo(
    apiServices: apiServices,
    profileRepo: profileRepo,
  );


  UserModel? userModel;
  Future<void> getProfileData() async {
    try {
      final user = await profileRepo.getProfileData();      if (!mounted) return;
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


  Future<void>autoLogin()async{
    final user = await authRepo.autoLogin();
    setState(() =>isGuest=authRepo.isGuest);
    if(user !=null){
      setState(() =>isGuest=authRepo.isGuest);
    }
  }

  @override
  void initState() {
    super.initState();
    autoLogin();

    context.read<CartCubit>().getCartData();
  }

  @override
  Widget build(BuildContext context) {
    if (isGuest) {
      return const GuestModeView();
    }

    return BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          //conditions

        },
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          final cartResponse = cubit.cartResponse;
         final bool isCartEmpty = cartResponse == null ||
              cartResponse.cartData.items.isEmpty;
          if (isCartEmpty) {
            return const CartEmpty();
          }


          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Expanded(
                    child:  ListView.builder(
                      itemCount: cartResponse.cartData.items.length,
                      itemBuilder: (context, index) {
                        final item = cartResponse.cartData.items[index];

                        return CustomCartItem(
                          image: item.image,
                          text: item.name,
                          desc: 'xxxx',
                          number: cubit.quantity![index],
                          onAdd: () => cubit.onAdd(index),
                          onMinus: () => cubit.onMinus(index),
                          onRemove: () =>
                              cubit.removeCartItem(item.itemId),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: cartResponse.cartData.totalPrice ,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),

                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 45,
                            width: 120,
                            child: CustomBtn(
                              heightSize: 45,
                              widthSize: double.infinity,
                              backgroundColor: ColorPalette.darkMocha,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CheckoutView(
                                      totalPrice:
                                      cartResponse.cartData.totalPrice ,
                                      cartItems: (cartResponse.cartData.items )
                                          .map((item) {
                                        return OrderItemModel(
                                          productId: item.productId,
                                          quantity: item.quantity,
                                          spicy: item.spicy,
                                          optionsByType: {
                                            'selectedOption': item.options,
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                              child: const CustomText(
                                text: 'Check Out',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Gap(20),
                ],
              ),
            ),
          );
        },
      );

    }}
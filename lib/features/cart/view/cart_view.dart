import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/view/widget/guest_mode.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/cart/view/widget/cart_empty.dart';
import 'package:hungry/features/cart/view/widget/cart_item.dart';
import 'package:hungry/features/checkout/data/model/order_item_model.dart';
import 'package:hungry/features/checkout/view/checkout_view.dart';
import 'package:hungry/shared/custom_btn.dart';
import 'package:hungry/shared/custom_snak.dart';
import 'package:hungry/shared/custom_text.dart';
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quantities = [];
  bool isLoading = false;
  bool isLoadingRemove = false;
  int? removingItemId;
  bool isGuest=false;
  final AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
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

  void onAdd(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void onMin(int index) {
    setState(() {
      if (quantities[index] > 1) quantities[index]--;
    });
  }



  GetCartResponseModel? cartResponse;
  CartRepo cartRepo = CartRepo();

  Future<void> getCartData() async {
    try {

      setState(() => isLoading = true);
      final res = await cartRepo.getCartData();
      log('getCart');
       final itemCount = res.cartData.items.length ;
      setState(() {
        cartResponse = res;
        if (itemCount == 0) {
          quantities = [];
          isLoading = false;
          return;
        }
        quantities = List.generate(itemCount, (_) => 1);

      });
      setState(() => isLoading = false);
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  Future<void>removeCartItem(int id)async{
    try{
     // setState(() => isLoadingRemove=true)
      await cartRepo.removeCartItem(id);

    //  setState(() => isLoadingRemove=false);

      customSnack('Remove Successfully');
    }catch (e){
      setState(() => isLoadingRemove=false);
      customSnack(e.toString());
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

      autoLogin();
      getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cartResponse != null && cartResponse!.cartData.items.isEmpty) {
      return const CartEmpty();
    }else
if(!isGuest)

{
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
            child: cartResponse == null
                ? const Center(child: CircularProgressIndicator(
              color: ColorPalette.primaryColor,))
                : ListView.builder(
              itemCount: cartResponse!.cartData.items.length,
              itemBuilder: (context, index) {
                final item = cartResponse!.cartData.items[index];
                return CustomCartItem(
                  image: item.image,
                  text: item.name,
                  desc: 'xxxx',
                  number: quantities[index],
                  onAdd: () => onAdd(index),
                  onMinus: () => onMin(index),
                  onRemove: () async {
                    setState(() {
                      removingItemId = item.itemId;
                    });
                    await removeCartItem(item.itemId);
                    await getCartData(); // هنا ممكن تسيب
                    log('item delete ');
                    await getCartData();
                    setState(() {
                      removingItemId = null;
                      customSnack('delete');
                    });
                  },
                );
              },
            ),
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              CustomText(
                text: cartResponse?.cartData.totalPrice ?? '90',
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
                            builder: (_) =>
                                CheckoutView(
                                  totalPrice: cartResponse?.cartData.totalPrice ?? '0.0',
                                  cartItems: (cartResponse?.cartData.items ?? []).map((item) {
                                    return OrderItemModel(
                                      productId: item.productId,
                                      quantity: item.quantity,
                                      spicy: item.spicy,
                                      optionsByType: {
                                        'selectedOption': item.options, // مباشرة من CartItemModel
                                      },
                                    );
                                  }).toList(),
                                ),
                        ));
                      },
                      child: const CustomText(
                        text: 'Check out',
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
          Gap(20),
        ],
      ),
    ),
  );
}
else if(isGuest){
  return GuestModeView();

}
return SizedBox();
  }

}
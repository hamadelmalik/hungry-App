import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/cart/view/widget/custom_cart_item.dart';
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



      final itemCount = res.cartData.items.length ;
      setState(() {
        cartResponse = res;
        quantities = List.generate(itemCount, (_) => 1);
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      isLoading = false;
    }
  }
  
  Future<void>removeCartItem(int id)async{
    try{
      setState(() => isLoadingRemove=true);
      final res =await cartRepo.removeCartItem(id);
      setState(() => isLoadingRemove=false);

      customSnack('Remove Successfully');
    }catch (e){
      setState(() => isLoadingRemove=false);
      customSnack(e.toString());
    }
  }

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: cartResponse!.cartData.items.length,
                      itemBuilder: (context, index) {
                        final item = cartResponse!.cartData.items[index];
                        return CustomCartItemNew(
                          image: item.image,
                          text: item.name,
                          desc: 'xxxx',
                          number: quantities[index],
                          onAdd: () => onAdd(index),
                          onMinus: () => onMin(index),
                          onRemove: () {
                            removeCartItem(item.itemId);
                          },
                        );
                      },
                    ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: '\$99.19',
                  fontSize: 22,
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
                        backgroundColor: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutView(),
                            ),
                          );
                        },
                        child: const CustomText(
                          text: 'Check out',
                          color: Colors.white,
                          fontSize: 18,
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
}

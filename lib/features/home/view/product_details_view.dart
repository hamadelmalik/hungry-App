import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/color_palette.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';
import 'package:hungry/features/home/cubit/home_cubit.dart';
import 'package:hungry/features/home/cubit/home_state.dart';
import 'package:hungry/features/home/view/spicy_slider.dart';
import 'package:hungry/features/home/view/widget/product_bottom_sheet.dart';
import 'package:hungry/features/home/view/widget/product_options_list.dart';
import 'package:hungry/shared/custom_snack.dart';

class ProductDetailsView extends StatefulWidget {
  final String productImage, productPrice;
  final int productId;

  const ProductDetailsView({
    super.key,
    required this.productImage,
    required this.productId,
    required this.productPrice,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double spicyValue = 0.5;


  @override


  void initState() {
    super.initState();
    context.read<HomeCubit>().getOptions();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(

      listener:(context,state) {
        if(state is AddToCartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Add to Cart Success')));
        }

          if(state is AddToCartError){
            ScaffoldMessenger.of(context).showSnackBar(
                customSnack(state.message));


        }
      },
      //conditions//
      builder: (context,state){
        final cubit=context.read<HomeCubit>();
        final loading = state is OptionsLoading;
        log('✅✅ options ${cubit.options.toString()}');

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: ColorPalette.primaryColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //--SpicySlider---//
                    SpicySlider(
                      img: widget.productImage,
                      value: spicyValue,
                      onChanged: (v) {
                        setState(() => spicyValue = v);
                      },
                    ),
                    Gap(20),

                    // ✅ Loop ديناميكي لكل نوع

                      ProductOptionsList(
                        isLoading: loading,
                        optionsByType: cubit.options,
                      ),

                    Gap(200),
                  ],
                ),
              ),
            ),
            //----------bottomSheet------//
            bottomSheet: ProductBottomSheet(
              productPrice: widget.productPrice,
              isLoading: state is AddToCartLoading,
                onTap: () {
          final cartItem = CartModel(
          productId: widget.productId,
          quantity: 1,
          spicy: spicyValue,
          optionTypeId: null,
          optionId: null,
          );

          cubit.addToCart(
          cartData: CartRequestModel(
          items: [cartItem],
          ),
          );
          },

            ),
          ),
        );
      },
      //return

    );
  }
}


import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/auth/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/cubit/auth_state.dart';
import 'package:hungry/features/home/cubit/home_cubit.dart';
import 'package:hungry/features/home/cubit/home_state.dart';
import 'package:hungry/features/home/view/widget/card_item.dart';
import 'package:hungry/features/home/view/widget/catogery_home.dart';
import 'package:hungry/features/home/view/widget/search_widget.dart';
import 'package:hungry/features/home/view/widget/user_header.dart';
import 'package:hungry/features/home/view/product_details_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatelessWidget  {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(
      builder: (context,state){
        final cubitHome=context.read<HomeCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Skeletonizer(
            enabled: state is HomeLoading  ,
            child: Scaffold(
              body: CustomScrollView(
                clipBehavior: Clip.none,
                slivers: [
                  //-----------------header---------------------//
                  BlocBuilder<AuthCubit,AuthStates>(
                     builder: (context,state){
                       final cubitAuth=context.read<AuthCubit>();
                 //      log("✅✅✅✅✅✅USER IMAGE: ${cubitAuth.userModel?.image}");
                       return SliverAppBar(
                         elevation: 0,
                         pinned: true,
                         floating: false,
                         toolbarHeight: 150,
                         scrolledUnderElevation: 0,
                         backgroundColor: Colors.white,
                         automaticallyImplyLeading: false,
                         flexibleSpace: ClipRRect(
                           borderRadius: BorderRadius.circular(30),

                           //  color: Colors.white.withAlpha(450).withOpacity(0.1),
                           child: Padding(
                             padding: const EdgeInsets.only(
                               top: 30,
                               right: 20,
                               left: 20,
                             ),
                             child: Column(
                               children: [
                                 UserHeader(
                                   userName: cubitAuth.userModel?.name ?? 'Guest',
                                   userImage: cubitAuth.userModel?.image ?? '',
                                 ),
                                 Gap(20),
                                 SearchWidget(
                                   controller: cubitHome.controller,
                                   onChanged: cubitHome.searchProduct,),
                               ],
                             ),
                           ),
                         ),
                       );
                     },

                  ),

                  /// ----------------------------Category--------------------
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: FoodHome(
                        category: cubitHome.category,
                        selectedIndex: cubitHome.selectedIndex,
                      ),
                    ),
                  ),

                  /// GridView
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.73,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: cubitHome.products?.length ?? 6,
                            (context, index) {
                          final product = cubitHome.products?[index];
                          log("Products Count: ${cubitHome.products?.length}");
                          if (product == null) {
                            return CupertinoActivityIndicator();
                          }
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => ProductDetailsView(
                                    productId: product.id,
                                    productPrice: product.price,
                                    productImage: product.image,
                                    //productImage: product.image,
                                  ),
                                ),
                              ),
                              child: CardItem(
                                name: product.name,
                                image: product.image,
                                desc: product.description,
                                rate: product.rate ?? '0.00',
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }

}

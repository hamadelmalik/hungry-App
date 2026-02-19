
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';
import 'package:hungry/features/home/view/widget/card_item.dart';
import 'package:hungry/features/home/view/widget/catogery_home.dart';
import 'package:hungry/features/home/view/widget/search_widget.dart';
import 'package:hungry/features/home/view/widget/user_header.dart';
import 'package:hungry/features/product/view/product_details_view.dart';
import 'package:hungry/shared/custom_snak.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combo', 'Sliders', 'Classic', 'Hot'];
  int selectedIndex = 0;
  List<ProductModel>? products;
  List<ProductModel>? allProducts;
  final TextEditingController controller=TextEditingController();
  final AuthRepo authRepo = AuthRepo();
  UserModel? userModel;


  ProductRepo productRepo = ProductRepo();

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
         errorMsg = e.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  Future<void> getProducts() async {
    final res = await productRepo.getProducts();

    if (!mounted) return;
    log('All products count: ${res.length}');

    setState(() {
      products = res;
      allProducts=res;
    });
  }

  @override
  void initState() {
    getProducts();
  getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          body: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              //-----------------header---------------------//
              SliverAppBar(
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
                          userName: userModel?.name ?? 'Guest',
                          userImage: userModel?.image ?? '',
                        ),
                        Gap(20),
                        SearchWidget(controller: controller,onChanged: (value){
                          final query=value.toLowerCase();

                          setState(() {
                            products = allProducts
                                ?.where((e) =>
                                e.name.toLowerCase().startsWith(query.toLowerCase()))
                                .toList();
                          });


                        },),
                      ],
                    ),
                  ),
                ),
              ),

              /// Category
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: FoodHome(
                    category: category,
                    selectedIndex: selectedIndex,
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
                    childCount: products?.length ?? 6,
                    (context, index) {
                      final product = products?[index];
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
  }

}

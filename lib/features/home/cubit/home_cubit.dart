import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';
import 'package:hungry/features/home/cubit/home_state.dart';
import 'package:hungry/features/home/data/model/option_model.dart';
import 'package:hungry/features/home/data/model/option_type.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/repo/home_repo.dart';
import 'package:hungry/features/home/data/repo/option_repo.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super (HomeInitial());
  List category = ['All', 'Combo', 'Sliders', 'Classic', 'Hot'];
  int selectedIndex = 0;
  Map<String, List<OptionModel>> options = {};
  final TextEditingController controller=TextEditingController();

  //getProduct function
  final HomeRepo homeRepo = HomeRepo();
  final OptionRepo optionRepo = OptionRepo();
  List<OptionType> optionTypes = [];
  List<ProductModel>? products;
  List<ProductModel>? allProducts;
  Future<void> getProducts() async {
    emit(HomeLoading());

    try {
      products = await homeRepo.getProducts();
      allProducts = List.from(products!);

      emit(HomeSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";

      if (e is ApiError) {
        errorMessage = e.message;
      }

      emit(HomeError(errorMessage));
    }
  }
  //search functions//
  void searchProduct(String value) {
    products = allProducts?.where((product) {
      return product.name.toLowerCase().contains(value.toLowerCase());
    }).toList();
    emit(HomeSuccess());
  }
  // Fetch option types (topping, side_options)
  Future<void> getOptionTypes() async {
    emit(OptionTypesLoading());

    try {
      optionTypes = await optionRepo.getOptionTypes();

      emit(OptionTypesSuccess());
      log('✅ options: ${options.toString()}');

    } on ApiError catch (e) {
      emit(OptionTypesError(e.message));
    } catch (_) {
      emit(OptionTypesError("Something went wrong"));
    }
  }
  // Fetch options (tomato, cheese, fries...)
  Future<void> getOptions() async {
    emit(OptionsLoading());

    try {
      options = await optionRepo.getOptions();

      emit(OptionsSuccess());
    } on ApiError catch (e) {
      emit(OptionsError(e.message));
    } catch (_) {
      emit(OptionsError("Something went wrong"));
    }
  }
  //-------AddToCart-----------------------
Future<void>addToCart({required CartRequestModel cartData})async{
    emit(AddToCartLoading());
    try{
      await homeRepo.addToCart(cartData);
      emit(AddToCartSuccess());

    }catch (e){
      String errorMessage='Some Thing Wrong';
      if(e is ApiError){
        errorMessage=e.message;

      }
      emit(AddToCartError(errorMessage));


    }



}



}




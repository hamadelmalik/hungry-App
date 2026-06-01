import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/home/cubit/home_state.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super (HomeInitial());
  List category = ['All', 'Combo', 'Sliders', 'Classic', 'Hot'];
  int selectedIndex = 0;
  final TextEditingController controller=TextEditingController();

  //getProduct function
   ProductRepo productRepo=ProductRepo();
  List<ProductModel>? products;
  List<ProductModel>? allProducts;
  Future getProducts()async {
    products=await productRepo.getProducts();
    emit(HomeLoading());
    try{

    }catch (e){
      String errorMessage = "Something went wrong";
      if( e is ApiError){
        errorMessage=e.message;
      }
      emit(HomeError(errorMessage));

    }
  }



}
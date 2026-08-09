import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/route/cubit/menu_state.dart';
import 'package:hungry/core/route/data/menu_items_model.dart';
import 'package:hungry/core/route/repo/menu_item_repo.dart';

class MenuCubit extends Cubit<MenuStates>{
  MenuCubit() :super(MenuInitial());
MenuItemRepo menuItemRepo=MenuItemRepo();
  int currentPage = 0;
  List<MenuItemModel> menuItems = [];
  void changePage(int index) {
    currentPage = index;

    emit(MenuPageChanged(menuItems));
  }


  Future<void> getMenuItems() async {
    log('🚀🚀🚀🚀 getMenuItems START');
    emit(MenuLoading());

    try {
      final items = await menuItemRepo.getMenuItemData();

      log('📡 menu: ${items.map((e) => e.route).toList()}');
      emit(MenuSuccess(items));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

}
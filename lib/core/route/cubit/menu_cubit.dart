import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/route/cubit/menu_state.dart';
import 'package:hungry/core/route/repo/menu_item_repo.dart';

class MenuCubit extends Cubit<MenuStates>{
  MenuCubit() :super(MenuInitial());
MenuItemRepo menuItemRepo=MenuItemRepo();

  Future<void> getMenuItems() async {
    emit(MenuLoading());

    try {
      final items = await menuItemRepo.getMenuItemData();
      emit(MenuSuccess(items));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

}
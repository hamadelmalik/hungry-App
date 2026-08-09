import 'package:hungry/core/route/data/menu_items_model.dart';

abstract class MenuStates{}
//login
class  MenuInitial extends MenuStates{}
class  MenuLoading extends MenuStates{}
class MenuSuccess extends MenuStates {
  final List<MenuItemModel> menuItems;

  MenuSuccess(this.menuItems);
}
class  MenuError extends MenuStates{
  final String message;
  MenuError(this.message);
}
class MenuPageChanged extends MenuStates {
  final List<MenuItemModel> menuItems;

  MenuPageChanged(this.menuItems);
}
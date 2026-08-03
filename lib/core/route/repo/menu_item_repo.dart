import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/route/data/menu_items_model.dart';

class MenuItemRepo {
  final ApiServices apiServices = ApiServices();

  Future<List<MenuItemModel>> getMenuItemData() async {
    try {
      final res = await apiServices.get('/menu-items');

      return (res as List).map((e) => MenuItemModel.fromJson(e)).toList();
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/model/cart_model.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  CartModel? cartResponse;
  List<int>? quantity = [];

  Future<void> getCartData() async {
    emit(GetCartLoading());

    try {
      final res = await cartRepo.getCartData();
      cartResponse = res;

      quantity = List.generate(
        res.cartData.items.length,
            (_) => 1,
      );

      emit(GetCartSuccess());
    } catch (e) {
      String errorMessage = 'Failed to get cart data';
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(GetCartError(message: errorMessage));
    }
  }

  Future<void> removeCartItem(int cartItemId) async {
    emit(RemoveCartLoading(cartItemId: cartItemId));
    try {
      await cartRepo.removeCartItem(cartItemId);
      await getCartData();
      emit(RemoveCartSuccess());
    } catch (e) {
      String errorMessage = 'Failed to Remove Cart Item';
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(RemoveCartError(message: errorMessage));
    }
  }

  void onAdd(int index) {
    quantity?[index]++;
    emit(GetCartSuccess());
  }

  void onMinus(int index) {
    if (quantity![index] > 1) {
      quantity?[index]--;
      emit(GetCartSuccess());
    }
  }
}

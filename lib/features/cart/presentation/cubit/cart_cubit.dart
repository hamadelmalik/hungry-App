import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/repo/Auth/auth_repo.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  final CartRepo cartRepo;
  final AuthRepo authRepo;

  CartCubit({
    required this.cartRepo,
    required this.authRepo,
  }) : super(CartInitial());

  // =========================
  // Cart Data
  // =========================

  dynamic cartResponse;

  List<int> quantity = [];

  // =========================
  // Guest
  // =========================

  bool isGuest = false;

  // =========================
  // Initialize Cart
  // =========================

  Future<void> initCart() async {
    await autoLogin();

    if (isGuest) {
      return;
    }

    await getCartData();
  }

  // =========================
  // Auto Login
  // =========================

  Future<void> autoLogin() async {
    emit(AutoLoginLoading());

    try {
      final user = await authRepo.autoLogin();

      isGuest = authRepo.isGuest;

      emit(AutoLoginSuccess());
    } catch (e) {
      emit(
        AutoLoginError(
          message: e is ApiError
              ? e.message.toString()
              : e.toString(),
        ),
      );
    }
  }

  // =========================
  // Get Cart
  // =========================

  Future<void> getCartData() async {
    emit(GetCartLoading());

    try {
      final response = await cartRepo.getCartData();

      cartResponse = response;

      quantity = response.cartData.items
          .map<int>((item) => item.quantity)
          .toList();

      emit(GetCartSuccess());
    } catch (e) {
      emit(
        GetCartError(
          message: e is ApiError
              ? e.message.toString()
              : e.toString(),
        ),
      );
    }
  }

  // =========================
  // Add Quantity
  // =========================

  void onAdd(int index) {
    if (index < 0 || index >= quantity.length) return;

    quantity[index]++;

    emit(GetCartSuccess());
  }

  // =========================
  // Minus Quantity
  // =========================

  void onMinus(int index) {
    if (index < 0 || index >= quantity.length) return;

    if (quantity[index] > 1) {
      quantity[index]--;

      emit(GetCartSuccess());
    }
  }

  // =========================
  // Remove Cart Item
  // =========================

  Future<void> removeCartItem(int cartItemId) async {
    emit(
      RemoveCartLoading(
        cartItemId: cartItemId,
      ),
    );

    try {
      await cartRepo.removeCartItem(cartItemId);

      emit(RemoveCartSuccess());

      await getCartData();
    } catch (e) {
      emit(
        RemoveCartError(
          message: e is ApiError
              ? e.message.toString()
              : e.toString(),
        ),
      );
    }
  }
}
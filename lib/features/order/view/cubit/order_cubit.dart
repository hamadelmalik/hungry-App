import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/repo/cart_repo.dart';
import 'package:hungry/features/order/data/model/order_model.dart';
import 'package:hungry/features/order/data/repo/order_repo.dart';
import 'package:hungry/features/order/view/cubit/order_states.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;
  final CartRepo cartRepo;

  OrderCubit({
    required this.orderRepo,
    required this.cartRepo,

  }) : super(OrderInitial());




// Create Order
  Future<void> createOrder(OrderModel order) async {
    emit(CreateOrderLoading());

    try {
      final result = await orderRepo.createOrder(order);

      if (result == null) {
        emit(CreateOrderError('Failed to create order'));
        return;
      }

      // Order created successfully
      emit(CreateOrderSuccess(result));


    } catch (e) {
      emit(CreateOrderError(e.toString()));
    }
  }


  // Get Order By ID
  Future<void> getOrderById(int orderId) async {
    emit(GetOrderByIdLoading());

    try {
      final result = await orderRepo.getOrderById(orderId);

      if (result != null) {
        emit(GetOrderByIdSuccess(result));
      } else {
        emit(GetOrderByIdError('No order found'));
      }
    } catch (e) {
      emit(GetOrderByIdError(e.toString()));
    }
  }

  //

}
import 'package:hungry/features/order/data/model/order_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

// ==================== Create Order ====================

class CreateOrderLoading extends OrderState {}

class CreateOrderSuccess extends OrderState {
  final OrderModel order;

  CreateOrderSuccess(this.order);
}

class CreateOrderError extends OrderState {
  final String message;

  CreateOrderError(this.message);
}

// ==================== Get Orders ====================

class GetOrdersLoading extends OrderState {}

class GetOrdersSuccess extends OrderState {
  final List<OrderModel> orders;

  GetOrdersSuccess(this.orders);
}

class GetOrdersError extends OrderState {
  final String message;

  GetOrdersError(this.message);
}

// ==================== Get Order By ID ====================

class GetOrderByIdLoading extends OrderState {}

class GetOrderByIdSuccess extends OrderState {
  final OrderModel order;

  GetOrderByIdSuccess(this.order);
}

class GetOrderByIdError extends OrderState {
  final String message;

  GetOrderByIdError(this.message);
}







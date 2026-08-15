abstract class CartStates{}
class CartInitial extends CartStates{}
//---get cart

class GetCartLoading extends CartStates{}
class GetCartSuccess extends CartStates{}
class GetCartError extends CartStates{
  String message='some thing went wrong';
  GetCartError({required this.message});
  }

//---Remove cart---------------//

class RemoveCartLoading extends CartStates{
  final int cartItemId;
  RemoveCartLoading( {required this.cartItemId});
}
class RemoveCartSuccess extends CartStates{}
class RemoveCartError extends CartStates{
  String message='some thing went wrong';
  RemoveCartError({required this.message});
}
//auto login

class AutoLoginLoading extends CartStates{}
class AutoLoginSuccess extends CartStates{}
class AutoLoginError extends CartStates{
  String message='some thing went wrong';
  AutoLoginError({required this.message});
}

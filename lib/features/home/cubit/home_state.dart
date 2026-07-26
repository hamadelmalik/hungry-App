abstract class HomeStates{}
class HomeInitial extends HomeStates{}
class HomeLoading extends HomeStates{}
class HomeSuccess extends HomeStates{}
class HomeError extends HomeStates{
  final String message;
  HomeError(this.message);
}
//AddToCart states////////
 class AddToCartLoading extends HomeStates{}
class AddToCartSuccess extends HomeStates{}
class AddToCartError extends HomeStates{
  final String message;
  AddToCartError(this.message);
}
// Fetch option types (topping, side_options)
class OptionTypesLoading extends HomeStates {}

class OptionTypesSuccess extends HomeStates {}

class OptionTypesError extends HomeStates {
  final String message;
  OptionTypesError(this.message);
}
// Fetch options (tomato, cheese, fries...)
class OptionsLoading extends HomeStates {}

class OptionsSuccess extends HomeStates {}

class OptionsError extends HomeStates {
  final String message;
  OptionsError(this.message);
}



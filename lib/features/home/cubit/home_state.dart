abstract class HomeStates{}
class HomeInitial extends HomeStates{}
class HomeLoading extends HomeStates{}
class HomeSuccess extends HomeStates{}
class HomeError extends HomeStates{
  final String message;
  HomeError(this.message);
}

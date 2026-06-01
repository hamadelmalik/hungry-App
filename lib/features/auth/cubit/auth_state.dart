abstract class AuthStates{}
class  AuthInitial extends AuthStates{}
class  AuthLoading extends AuthStates{}
class  AuthError extends AuthStates{
  final String message;
  AuthError(this.message);
}

class  AuthSuccess extends AuthStates{}

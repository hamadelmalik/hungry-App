abstract class AuthStates{}
//login
class  AuthInitial extends AuthStates{}
class  LoginLoading extends AuthStates{}
class  LoginSuccess extends AuthStates{}
class  LoginError extends AuthStates{
  final String message;
  LoginError(this.message);
}

//singUp

class  SignUpSuccess  extends AuthStates{}
class  SignUpLoading extends AuthStates{}
class  SignUpError extends AuthStates{
  final String message;
  SignUpError(this.message);
}


//Logout---

class  LogoutLoading extends AuthStates{}
class  LogoutSuccess extends AuthStates{}
class  LogoutError extends AuthStates{
  final String message;
  LogoutError(this.message);
}
// Auto Login
class AutoLoginLoading extends AuthStates {}

class AutoLoginSuccess extends AuthStates {}

class AutoLoginError extends AuthStates {
  final String message;
  AutoLoginError(this.message);
}
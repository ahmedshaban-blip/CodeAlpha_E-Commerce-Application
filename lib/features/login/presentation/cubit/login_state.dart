abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  // final result;
  // Success(this.result);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

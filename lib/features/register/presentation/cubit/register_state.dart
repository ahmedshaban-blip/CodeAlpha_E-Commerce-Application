import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;

  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}

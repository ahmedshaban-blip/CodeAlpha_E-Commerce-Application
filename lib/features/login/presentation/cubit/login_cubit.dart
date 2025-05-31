import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      String emailAuth = email;
      String passwordAuth = password;

      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAuth,
        password: passwordAuth,
      );

      await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(userCredential.credential!);

      emit(LoginSuccess());
    }
    // emit(LoginSuccess(result));
    catch (e) {
      if (isClosed) {
        print('Error after cubit is closed: $e');
      } else {
        emit(LoginFailure(e.toString()));
      }
    }
  }
}

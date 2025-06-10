// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitial());

//   Future<void> login(String email, String password) async {
//     emit(LoginLoading());
//     try {
//       String emailAuth = email;
//       String passwordAuth = password;

//       final userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailAuth,
//         password: passwordAuth,
//       );

//       await FirebaseAuth.instance.currentUser
//           ?.linkWithCredential(userCredential.credential!);

//       emit(LoginSuccess());
//     }
//     // emit(LoginSuccess(result));
//     catch (e) {
//       if (isClosed) {
//         print('Error after cubit is closed: $e');
//       } else {
//         emit(LoginFailure(e.toString()));
//       }
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      // طباعة للتأكد من البيانات
      print('Attempting login with email: $email');

      // تسجيل الدخول بـ Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      // التحقق من أن تسجيل الدخول تم بنجاح
      if (userCredential.user != null) {
        print('Login successful for user: ${userCredential.user!.email}');
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('فشل في تسجيل الدخول'));
      }
    } catch (e) {
      print('Login error: $e');
      if (isClosed) {
        print('Error after cubit is closed: $e');
      } else {
        // تحسين رسائل الخطأ
        String errorMessage = _getErrorMessage(e);
        emit(LoginFailure(errorMessage));
      }
    }
  }

  // دالة لتحسين رسائل الخطأ
  String _getErrorMessage(dynamic error) {
    print('Error details: $error');
    if (error is FirebaseAuthException) {
      print('Firebase Auth Error Code: ${error.code}');
      switch (error.code) {
        case 'user-not-found':
          return 'البريد الإلكتروني غير مسجل';
        case 'wrong-password':
          return 'كلمة المرور غير صحيحة';
        case 'invalid-email':
          return 'البريد الإلكتروني غير صالح';
        case 'user-disabled':
          return 'تم تعطيل هذا الحساب';
        case 'too-many-requests':
          return 'محاولات كثيرة جداً، حاول مرة أخرى لاحقاً';
        case 'invalid-credential':
          return 'بيانات تسجيل الدخول غير صحيحة';
        case 'network-request-failed':
          return 'تحقق من اتصال الإنترنت';
        case 'operation-not-allowed':
          return 'تسجيل الدخول بالبريد الإلكتروني غير مفعل';
        default:
          return 'حدث خطأ: ${error.message ?? error.code}';
      }
    }
    return 'حدث خطأ غير متوقع: ${error.toString()}';
  }

  // دالة لإنشاء حساب جديد (للاختبار)
  Future<void> createAccount(String email, String password) async {
    emit(LoginLoading());
    try {
      print('Creating account for: $email');

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      if (userCredential.user != null) {
        print(
            'Account created successfully for: ${userCredential.user!.email}');
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('فشل في إنشاء الحساب'));
      }
    } catch (e) {
      print('Create account error: $e');
      if (isClosed) {
        print('Error after cubit is closed: $e');
      } else {
        String errorMessage = _getCreateAccountErrorMessage(e);
        emit(LoginFailure(errorMessage));
      }
    }
  }

  String _getCreateAccountErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'هذا البريد الإلكتروني مستخدم بالفعل';
        case 'weak-password':
          return 'كلمة المرور ضعيفة جداً';
        case 'invalid-email':
          return 'البريد الإلكتروني غير صالح';
        default:
          return 'حدث خطأ في إنشاء الحساب: ${error.message ?? error.code}';
      }
    }
    return 'حدث خطأ غير متوقع: ${error.toString()}';
  }

  // دالة لتسجيل الخروج
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}

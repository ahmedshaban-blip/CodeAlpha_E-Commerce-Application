import 'package:e_commerce/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce/features/login/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // إذا كان في عملية تحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // إذا كان المستخدم مسجل دخول
        if (snapshot.hasData && snapshot.data != null) {
          return HomePage(); // استبدلها بصفحتك الرئيسية
        }

        // إذا كان المستخدم غير مسجل دخول
        return const loginScreen(); // استبدلها بصفحة تسجيل الدخول
      },
    );
  }
}

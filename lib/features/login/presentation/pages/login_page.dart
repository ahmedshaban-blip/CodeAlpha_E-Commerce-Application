// import 'package:e_commerce/core/routing/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/login_cubit.dart';
// import '../cubit/login_state.dart';

// class loginScreen extends StatelessWidget {
//   const loginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     return BlocProvider(
//       create: (_) => LoginCubit(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Login Page')),
//         body: BlocConsumer<LoginCubit, LoginState>(
//           listener: (context, state) {
//             if (state is LoginSuccess) {
//               // النقل للصفحة الرئيسية فقط عند نجاح تسجيل الدخول
//               Navigator.pushReplacementNamed(context, Routes.HomePage);
//             } else if (state is LoginFailure) {
//               // إظهار رسالة خطأ
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('خطأ في تسجيل الدخول: ${state.error}'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is LoginLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: state is LoginLoading
//                         ? null
//                         : () {
//                             // التحقق من أن الحقول مش فاضية
//                             if (emailController.text.isEmpty ||
//                                 passwordController.text.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('يرجى ملء جميع الحقول'),
//                                   backgroundColor: Colors.orange,
//                                 ),
//                               );
//                               return;
//                             }

//                             context.read<LoginCubit>().login(
//                                 emailController.text, passwordController.text);
//                           },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                     child: state is LoginLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text('Login'),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:e_commerce/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: Colors.blueGrey.shade900,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // النقل للصفحة الرئيسية فقط عند نجاح تسجيل الدخول
              Navigator.pushReplacementNamed(context, Routes.HomePage);
            } else if (state is LoginFailure) {
              // إظهار رسالة خطأ
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('خطأ في تسجيل الدخول: ${state.error}'),
                  backgroundColor: Colors.red.shade700,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                  child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.blueGrey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'example@example.com',
                      hintStyle: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                    ),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '********',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            // التحقق من أن الحقول مش فاضية
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('يرجى ملء جميع الحقول'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }

                            context.read<LoginCubit>().login(
                                emailController.text, passwordController.text);
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.blueGrey.shade900,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: state is LoginLoading
                        ? const CircularProgressIndicator.adaptive(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))
                        : const Text(
                            'تسجيل الدخول',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 15),
                  // زر إنشاء حساب جديد
                  OutlinedButton(
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            // التحقق من أن الحقول مش فاضية
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('يرجى ملء جميع الحقول'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }

                            // التحقق من قوة كلمة المرور
                            if (passwordController.text.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'كلمة المرور يجب أن تكون 6 أحرف على الأقل'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }

                            context.read<LoginCubit>().createAccount(
                                emailController.text, passwordController.text);
                          },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      side: BorderSide(
                        color: Colors.blueGrey.shade900,
                        width: 2,
                      ),
                    ),
                    child: state is LoginLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2),
                          )
                        : const Text(
                            'إنشاء حساب جديد',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

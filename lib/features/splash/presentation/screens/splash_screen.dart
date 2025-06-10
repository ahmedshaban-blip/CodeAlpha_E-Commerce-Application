// import 'dart:async';

// import 'package:flutter/material.dart';

// import '../../../../core/extensions/navigation_extensions.dart';
// import '../../../../core/routing/routes.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FlutterLogo(size: 100),
//             SizedBox(height: 20),
//             Text("Splash Screen", style: TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       context.pushNamed(Routes.onBoardingScreen);
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // انتظار لمدة 3 ثواني (أو أقل حسب احتياجك)
    await Future.delayed(const Duration(seconds: 3));

    // التحقق من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (!mounted) return;

    if (hasSeenOnboarding) {
      // إذا شاف الـ OnBoarding قبل كده، روح على AuthWrapper
      Navigator.pushReplacementNamed(context, '/AuthWrapper');
    } else {
      // إذا مشافوش، روح على OnBoarding
      Navigator.pushReplacementNamed(context, '/onBoardingScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // أو أي لون تحبه
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_cart,
                size: 80,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),

            // اسم التطبيق
            const Text(
              'E-Commerce',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              'تطبيق التجارة الإلكترونية',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 50),

            // مؤشر التحميل
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

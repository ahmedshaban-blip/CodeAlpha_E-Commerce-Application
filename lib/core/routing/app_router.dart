import 'package:e_commerce/features/home/presentation/pages/home_page.dart';
import 'package:e_commerce/features/login/presentation/pages/auth_wraper.dart';
import 'package:e_commerce/features/login/presentation/pages/login_page.dart';
import 'package:e_commerce/features/productdetails/presentation/pages/productdetails_page.dart';
import 'package:flutter/material.dart';
import '../routing/routes.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/data/models/home_model.dart'; // تأكد تستورد الـ model هنا

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _createRoute(const SplashScreen());
      case Routes.onBoardingScreen:
        return _createRoute(const OnboardingScreen());
      case Routes.AuthWrapper:
        return _createRoute(AuthWrapper());
      case Routes.loginScreen:
        return _createRoute(const loginScreen());
      case Routes.HomePage:
        return _createRoute(HomePage());
      case Routes.ProductdetailsPage:
        final product = settings.arguments as ProductModel;
        return _createRoute(ProductdetailsPage(products: product));
      // يمكن تضيف CheckoutPage هنا بالمثل إذا تحتاج
      default:
        return null;
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

import 'package:e_commerce/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/cubit/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'core/constants/app_constants.dart';
import 'core/cubit/locale/locale_cubit.dart';
import 'core/cubit/theme/theme_cubit.dart';
import 'core/utils/app_shared_preferences.dart';
import 'core/routing/app_router.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['publishable_key']!;
  ;
  Bloc.observer = AppBlocObserver();
  await AppPreferences().init();

  runApp(
    EasyLocalization(
      supportedLocales: AppConstants.supportedLocales,
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // ← حسب تصميمك من Figma أو XD
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => LocaleCubit()),
              BlocProvider(create: (_) => ThemeCubit()),
              BlocProvider(
                  create: (_) =>
                      CartCubit()..loadCart()), // ✅ حمّل البيانات مباشرة

              BlocProvider(
                  create: (_) => HomeCubit()), // لو عندك HomeCubit مثلاً
            ],
            child: MyApp(appRouter: AppRouter()),
          );
        },
      ),
    ),
  );
}

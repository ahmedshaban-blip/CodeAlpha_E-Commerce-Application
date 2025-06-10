import 'package:e_commerce/core/utils/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'core/constants/app_constants.dart';
import 'core/cubit/locale/locale_cubit.dart';
import 'core/cubit/theme/theme_cubit.dart';
import 'core/utils/app_shared_preferences.dart';
import 'core/routing/app_router.dart';
import 'app.dart';
import 'app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();
  Stripe.publishableKey = Keys().publishable_key;
  Bloc.observer = AppBlocObserver();
  await AppPreferences().init();

  runApp(EasyLocalization(
    supportedLocales: AppConstants.supportedLocales,
    path: 'assets/lang',
    fallbackLocale: const Locale('en'),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: MyApp(appRouter: AppRouter()),
    ),
  ));
}

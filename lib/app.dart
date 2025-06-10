import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_theme.dart' hide AppTheme;
import 'core/routing/app_router.dart';
import 'core/constants/app_constants.dart';
import 'core/cubit/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.lightTheme, // ← فقط ده هو الثيم الفاتح
        darkTheme: AppTheme.darkTheme, // ← فقط ده هو الثيم الداكن
        themeMode: themeState.themeMode, // ← حسب الحالة المختارة
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}

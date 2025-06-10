import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Nunito',
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.backgroundColor,
        cardColor: AppColor.surfaceColor,
        hintColor: AppColor.gray,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.black),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.black,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColor.lightTextColor),
          bodyMedium: const TextStyle(color: AppColor.gray),
          titleLarge: const TextStyle(
              color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            foregroundColor: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColor.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: AppColor.gray),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Nunito',
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.darkBackground,
        cardColor: AppColor.darkSurface,
        hintColor: AppColor.darkHintColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.darkSurface,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.white),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.white,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColor.darkTextColor),
          bodyMedium: TextStyle(color: AppColor.darkHintColor),
          titleLarge: const TextStyle(
              color: AppColor.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            foregroundColor: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColor.darkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: AppColor.darkHintColor),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:pokemon/theme/theme.dart';

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkScaffold,
      useMaterial3: true,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: AppColors.white,
          fontSize: 46,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 26,
        ),
        headline3: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        headline4: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
        bodyText1: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
        caption: TextStyle(
          color: AppColors.white,
          fontSize: 12,
        ),
        overline: TextStyle(
          color: AppColors.white,
          fontSize: 12,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.heavyDark,
      ),
    );
  }
}
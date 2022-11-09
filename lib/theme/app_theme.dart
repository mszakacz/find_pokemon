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
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        headline3: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        headline4: TextStyle(
          color: AppColors.white,
          fontSize: 16,
        ),
        headline5: TextStyle(
          color: AppColors.white,
          fontSize: 14,
        ),
        headline6: TextStyle(
          color: AppColors.white,
          fontSize: 13,
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
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkScaffold),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.heavyDark,
      ),
    );
  }
}

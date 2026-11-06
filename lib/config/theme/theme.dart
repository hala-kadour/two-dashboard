import 'package:flutter/material.dart';

import 'color.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: AppColors.mainColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.navy),
      textTheme: TextTheme(),
      floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
        backgroundColor: AppColors.mainColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          // ignore: deprecated_member_use
          AppColors.mainColor.value,
          const {
            50: AppColors.mainColor,
            100: AppColors.mainColor,
            200: AppColors.mainColor,
            300: AppColors.mainColor,
            400: AppColors.mainColor,
            500: AppColors.mainColor,
            600: AppColors.mainColor,
            700: AppColors.mainColor,
            800: AppColors.mainColor,
            900: AppColors.mainColor,
          },
        ),
      ).copyWith(secondary: AppColors.secondaryColor),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: AppColors.darkMainColor,
      scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.darkCardColor),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.darkDrawerBackgroundColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
        backgroundColor: AppColors.darkMainColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          // ignore: deprecated_member_use
          AppColors.darkMainColor.value,
          const {
            50: AppColors.darkMainColor,
            100: AppColors.darkMainColor,
            200: AppColors.darkMainColor,
            300: AppColors.darkMainColor,
            400: AppColors.darkMainColor,
            500: AppColors.darkMainColor,
            600: AppColors.darkMainColor,
            700: AppColors.darkMainColor,
            800: AppColors.darkMainColor,
            900: AppColors.darkMainColor,
          },
        ),
      ).copyWith(secondary: AppColors.darkIconColor),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkFontLightColor),
        bodyMedium: TextStyle(color: AppColors.darkFontDarkColor),
      ),
    );
  }
}

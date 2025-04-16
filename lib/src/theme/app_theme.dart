import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

import 'app_fonts.dart';

ThemeData get appTheme => buildTheme();

ThemeData buildTheme() {
  final primaryColor = AppColors.primaryColor;
  return ThemeData(
    colorScheme: ColorScheme.light(primary: primaryColor),
    appBarTheme: AppBarTheme(),
    hintColor: AppColors.hintColor,
    useMaterial3: true,
    fontFamily: AppFonts.manrope,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xffF8ED8C)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xffF8ED8C)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: primaryColor),
        foregroundColor: primaryColor,
        textStyle: TextStyle(fontSize: 16),
      ),
    ),
  );
}

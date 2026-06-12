import 'package:flutter/material.dart';
import 'package:xinyue/constant/app_colors.dart';

/// 亮色主题
ThemeData get lightTheme => ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryLight,
  colorScheme: const ColorScheme.light(
    primary: primaryLight,
    secondary: secondaryLight,
    surface: cardLight,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: textPrimaryLight,
  ),
  scaffoldBackgroundColor: backgroundLight,
  cardColor: cardLight,
  cardTheme: const CardThemeData(
    elevation: 2,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: primaryLight,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textPrimaryLight,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: textPrimaryLight),
    bodyMedium: TextStyle(fontSize: 14, color: textSecondaryLight),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primaryLight,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryLight,
      minimumSize: const Size(88, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
);

/// 暗色主题
ThemeData get darkTheme => ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryDark,
  colorScheme: const ColorScheme.dark(
    primary: primaryDark,
    secondary: secondaryDark,
    surface: cardDark,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: textPrimaryDark,
  ),
  scaffoldBackgroundColor: backgroundDark,
  cardColor: cardDark,
  cardTheme: const CardThemeData(
    elevation: 2,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: backgroundDark,
    foregroundColor: textPrimaryDark,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textPrimaryDark,
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textPrimaryDark,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: textPrimaryDark),
    bodyMedium: TextStyle(fontSize: 14, color: textSecondaryDark),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: primaryDark,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: primaryDark,
      minimumSize: const Size(88, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2C2C2C),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
);

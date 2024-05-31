import 'package:flutter/material.dart';

class TravelTheme {
  static const _primaryColor = Color(0xFFFF6F00); // Turuncu

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      primaryContainer: Color(0xFFFFD180), // Daha soluk turuncu
      onPrimary: Colors.white,
      secondary: Color(0xFFFFA270), // İkinci turuncu tonu
      secondaryContainer: Color(0xFFFFF1E8), // Daha soluk ikinci turuncu
      onSecondary: Colors.black,
      surface: Colors.white,
      // ignore: deprecated_member_use
      background: Color(0xFFFFF8E1), // Açık sarı arka plan
      // ignore: deprecated_member_use
      onBackground: Colors.black,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF8E1), // Açık sarı arka plan
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: _primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      primaryContainer: Color(0xFFFFBD7B), // Daha soluk turuncu
      onPrimary: Colors.black,
      secondary: Color(0xFFFFA270), // İkinci turuncu tonu
      secondaryContainer: Color(0xFFBF360C), // Daha koyu ikinci turuncu
      onSecondary: Colors.black,
      surface: Color(0xFF303030),
      // ignore: deprecated_member_use
      background: Color(0xFF424242), // Daha koyu gri arka plan
      // ignore: deprecated_member_use
      onBackground: Colors.white,
      error: Color(0xFFCF6679),
      onError: Colors.black,
      onSurface: Colors.white,
    ),
    // ignore: prefer_const_constructors
    scaffoldBackgroundColor: Color(0xFF424242), // Daha koyu gri arka plan
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.black,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: _primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    ),
  );
}

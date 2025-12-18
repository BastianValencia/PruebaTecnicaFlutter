import 'package:flutter/material.dart';

class AppTheme {
  // --- Colores Nuevos (Templado / Grayscale) ---
  static const _primaryColor = Colors.black; 
  static const _secondaryColor = Color(0xFF757575); // Grey 600
  static const _backgroundColor = Color.fromARGB(255, 233, 230, 230); // Almost White
  static const _surfaceColor = Colors.white;

  // --- Dark Mode ---
  static const _darkPrimary = Colors.white; 
  static const _darkSecondary = Color(0xFFBDBDBD); // Grey 400
  static const _darkBackground = Color(0xFF121212); 
  static const _darkSurface = Color(0xFF1E1E1E);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        surface: _surfaceColor,
        background: _backgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, // In monochrome, white app bar is cleaner
        foregroundColor: Colors.black, // Dark text
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      cardTheme: CardThemeData(
        elevation: 0, 
        color: _surfaceColor,
        surfaceTintColor: Colors.transparent, 
        shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
           side: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryColor,
          side: const BorderSide(color: _primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimary,
        secondary: _darkSecondary,
        surface: _darkSurface,
        background: _darkBackground,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
      ),
      scaffoldBackgroundColor: _darkBackground,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: Colors.white,
        elevation: 0, 
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

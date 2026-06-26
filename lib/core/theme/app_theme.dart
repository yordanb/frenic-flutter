import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Elevated
  static const _primaryColor = Color(0xFF00BFA5);
  static const _secondaryColor = Color(0xFF1A237E);
  static const _surfaceDark = Color(0xFF1E1E2C);
  static const _cardDark = Color(0xFF252536);
  static const _scaffoldDark = Color(0xFF16161F);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _scaffoldDark,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: _surfaceDark,
    ),
    cardTheme: CardTheme(
      color: _cardDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.copyWith(
            headlineLarge: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
            headlineMedium: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors - Vedic Inspired
  static const Color _primary = Color(0xFF8B5A2B); // Earthy Brown
  static const Color _secondary = Color(0xFFDAA520); // Golden
  static const Color _accent = Color(0xFF8B0000); // Deep Red
  static const Color _backgroundLight = Color(0xFFFFF8F0); // Soft Beige
  static const Color _backgroundDark = Color(0xFF1A120B); // Dark Brown
  static const Color _surfaceLight = Color(0xFFFFF8F0); // Off-White
  static const Color _surfaceDark = Color(0xFF2A1E17); // Dark Surface
  static const Color _textLight = Color(0xFF3E2723); // Dark Brown Text
  static const Color _textDark = Color(0xFFEFEBE9); // Light Beige Text

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.light,
        surface: _surfaceLight,
        // background: _backgroundLight, // Deprecated in some versions, but surface covers it
      ),
      scaffoldBackgroundColor: _backgroundLight,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: _textLight,
        displayColor: _textLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _surfaceLight,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primary,
        brightness: Brightness.dark,
        surface: _surfaceDark,
      ),
      scaffoldBackgroundColor: _backgroundDark,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: _textDark.withOpacity(0.87),
        displayColor: _textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _surfaceDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}

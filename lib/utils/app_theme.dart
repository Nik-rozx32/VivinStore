import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryDark = Colors.black;
  static const Color primaryMedium = Color(0xFF8B4513);
  static const Color accent = Color(0xFFD4AF37);
  static const Color background = Color(0xFFFAF9F7);
  static const Color textDark = Colors.black;
  static const Color textMedium = Color(0xFF666666);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryMedium,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: 'Georgia',
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  // Text Styles
  static const TextStyle heroTitle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(2, 2),
        blurRadius: 4,
        color: Colors.black26,
      ),
    ],
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 20,
    color: Colors.white70,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static const TextStyle productName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static const TextStyle productPrice = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: primaryMedium,
  );

  static const TextStyle productDescription = TextStyle(
    fontSize: 14,
    color: textMedium,
  );
}

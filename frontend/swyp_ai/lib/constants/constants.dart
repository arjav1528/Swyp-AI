// constants.dart
import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primaryColor = Color.fromARGB(255, 0, 0, 0);
  static const Color secondaryColor = Colors.black;
  static const Color textColor = Colors.white;
  static const Color accentColor = Colors.blue; // Added accent color
  static const Color disabledColor = Colors.grey;

  static TextTheme get _textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, color: textColor),
      bodySmall: TextStyle(fontSize: 12, color: textColor),
    );
  }

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
      ),
      textTheme: _textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: accentColor, // Use accent color
          textStyle: _textTheme.bodyLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), //Consistent border radius
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 12,
          ), //Consistent padding
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Add this section
        hintStyle: TextStyle(color: disabledColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: accentColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: accentColor),
        ),
      ), // Background color for dialogs
      textButtonTheme: TextButtonThemeData(
        // Style for TextButtons in Dialogs
        style: TextButton.styleFrom(foregroundColor: textColor),
      ),
      dialogTheme: DialogThemeData(backgroundColor: const Color(0xFF101e32)),
    );
  }
}

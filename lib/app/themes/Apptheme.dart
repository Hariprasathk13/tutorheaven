import 'package:flutter/material.dart';

class Apptheme {
  static final ThemeData aiLightTheme = ThemeData(
    primaryColor: Color(0xFF4A90E2),
    hintColor: Color(0xFFF5A623),
    backgroundColor: Color(0xFFFFFFFF),
    scaffoldBackgroundColor: Color(0xFFF0F0F0),
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16),
    ),
  );

  static final ThemeData aiDarkTheme = ThemeData(
    primaryColor: Color(0xFF0D1B2A),
    hintColor: Color(0xFF00FFF0),
    backgroundColor: Color(0xFF121212),
    scaffoldBackgroundColor: Color(0xFF1E1E1E),
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16),
    ),
  );
}

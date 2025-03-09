import 'package:flutter/material.dart';

class MainThemeData {
  static ThemeData themeData = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.blue[100],
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.blue[700],
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(
          color: Colors.white,
        ),
      ),
      indicatorColor: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[700],
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
    ),
  );
}

import 'package:flutter/material.dart';

class DarkTheme {
  late ThemeData theme;

  DarkTheme() {
    theme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        background: Colors.black,
      ),
      primaryColor: Colors.white,
      textTheme: ThemeData.dark().textTheme.copyWith(
        headlineMedium: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 30),
        titleLarge: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),
        headlineSmall: TextStyle(color: Colors.white,fontSize: 26),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Color(0xff212121),
      ),
      cardTheme: CardTheme(
        color: Color(0xff000320),
      )
    );
  }
}

import 'package:flutter/material.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      colorScheme: ColorScheme.light(
          background: Colors.white,
      ),
      primaryColor: Colors.black,
      textTheme: TextTheme(
        headlineMedium: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 30),
        titleLarge: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
        headlineSmall: TextStyle(color: Colors.black,fontSize: 26),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Color(0xffFEFAFA),
      )
    );
  }
}

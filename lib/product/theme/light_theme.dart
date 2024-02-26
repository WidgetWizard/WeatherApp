
import 'package:flutter/material.dart';

class LightTheme{
  late ThemeData theme;

  LightTheme(){
    theme = ThemeData(
      useMaterial3: true,
      primaryColor: Colors.black,
      /*primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,*/
      colorScheme: ColorScheme.light(background: Colors.white),
      /*buttonTheme: ButtonThemeData(
        buttonColor: Color(0xff0f1bbf),
        highlightColor: Colors.red,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.black,),
        displayLarge: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black),
        displaySmall: TextStyle(color: Colors.black),
      ),*/
    );
  }
}



import 'package:flutter/material.dart';

class DarkTheme{
  late ThemeData theme;

  DarkTheme(){
    theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(background: Colors.black),
      primaryColor: Colors.white,
    );
  }
}
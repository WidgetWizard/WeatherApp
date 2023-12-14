import 'package:flutter/material.dart';

class RndmBackGround {
  String category = 'nature';
  late final String url;
  RndmBackGround() {
    url = 'https://api.api-ninjas.com/v1/randomimage?category=$category';
  }
  Image getBackgroundImage() {
    return Image.network(url);
  }
}

import 'package:flutter/material.dart';

class RndmBackGround {
  String category = 'nature';
  late final String url;
  RndmBackGround() {
    url = 'https://api.api-ninjas.com/v1/randomimage?category=$category';
  }
  ImageProvider getBackgroundImage() {
    return Image.network(url).image;
  }
}

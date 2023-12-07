import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final url = '$BASE_URL?q=$cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Error getting weather for location');
    }

    return Weather.fromJson(jsonDecode(response.body));
  }

  Future<String> getCurrentCity() async {
    //
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch current location
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //convert location into a list of placemark adress
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract the city name from the placemark list
    String? cityName = placemarks[0].locality;
    return cityName ?? 'Bilinmiyor';
  }
}

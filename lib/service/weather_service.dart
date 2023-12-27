import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/weather_model.dart';

abstract class IWeatherService{
  final String _apiKey;
  final String _baseUrl;
  IWeatherService({required String apiKey,required String baseUrl}) : _apiKey = apiKey, _baseUrl = baseUrl;
  Future<WeatherModel?> getWeatherData();
  Future<void> getLocationWithPermission();
  }

class WeatherService extends IWeatherService{
  double? _latitude;
  double? _longitude;
  WeatherService({required super.apiKey, required super.baseUrl});

  @override
  Future<WeatherModel?> getWeatherData() async {
    if (_longitude != null || _longitude != null) {
      final response = await http.get(Uri.parse(
          "$_baseUrl/weather?lat=$_latitude&lon=$_longitude&units=metric&lang=tr&appid=$_apiKey"));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      }
    }
    return null;
  }

  @override
  Future<void> getLocationWithPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      _latitude = position.latitude;
      _longitude = position.longitude;
    }
  }
}

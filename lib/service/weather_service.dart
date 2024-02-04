import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/weather_five_days_with_three_hours_model.dart';
import '../model/weather_model.dart';

abstract class IWeatherService<T>{
  final String _apiKey;
  final String _baseUrl;
  double? _latitude;
  double? _longitude;
  IWeatherService({required String apiKey,required String baseUrl}) : _apiKey = apiKey, _baseUrl = baseUrl;
  Future<T?> getWeatherData();
  Future<void> getLocationWithPermission()async {
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

class CurrentWeatherService extends IWeatherService{
  CurrentWeatherService({required super.apiKey, required super.baseUrl});
  @override
  Future<WeatherModel?> getWeatherData() async {
    if (_longitude != null && _latitude != null) {
      final response = await http.get(Uri.parse(
          "$_baseUrl/weather?lat=$_latitude&lon=$_longitude&units=metric&lang=tr&appid=$_apiKey"));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      }
    }
    return null;
  }
}

class WeatherServiceForFiveDaysWithThreeHours extends IWeatherService{
  WeatherServiceForFiveDaysWithThreeHours({required super.apiKey, required super.baseUrl});
  @override
  Future<WeatherFiveDaysWithThreeHourModel?> getWeatherData() async {
    if (_longitude != null && _latitude != null) {
      final response = await http.get(Uri.parse(
          "$_baseUrl/forecast?lat=$_latitude&lon=$_longitude&units=metric&lang=tr&appid=$_apiKey"));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData != null) {
          return WeatherFiveDaysWithThreeHourModel.fromJson(decodedData);
        }
      }
    }
    return null;
  }
}
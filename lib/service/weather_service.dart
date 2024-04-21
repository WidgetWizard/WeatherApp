import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/product/extension/temperature_units.dart';
import 'dart:convert';
import '../model/weather_five_days_with_three_hours_model.dart';
import '../model/weather_model.dart';

abstract class IWeatherService<T> {
  final String _apiKey;
  final String _baseUrl;
  double? _latitude;
  double? _longitude;
  IWeatherService({required String apiKey, required String baseUrl})
      : _apiKey = apiKey,
        _baseUrl = baseUrl;
  Future<T?> getWeatherData({required String unit});
  Future<void> getLocationWithPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      _latitude = position.latitude;
      _longitude = position.longitude;
    }
  }

  String getApiUrl({required String tempUnit, required String evolvedUrl}) {
    String units = tempUnit.toLowerCase();
    if (tempUnit == TemperatureUnit.Default.name) {
      return evolvedUrl;
    }
    return "$evolvedUrl&units=$units";
  }
}

class CurrentWeatherService extends IWeatherService<WeatherModel> {
  CurrentWeatherService({required super.apiKey, required super.baseUrl});
  @override
  Future<WeatherModel?> getWeatherData({required String unit}) async {
    if (_longitude != null && _latitude != null) {
      var evolvedUrl = "$_baseUrl/weather?lat=$_latitude&lon=$_longitude&lang=tr&appid=$_apiKey";
      final response = await http.get(Uri.parse(getApiUrl(tempUnit: unit, evolvedUrl: evolvedUrl)));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      }
    }
    print(unit);
    return null;
  }
}

class WeatherServiceForFiveDaysWithThreeHours extends IWeatherService<WeatherFiveDaysWithThreeHourModel> {
  WeatherServiceForFiveDaysWithThreeHours(
      {required super.apiKey, required super.baseUrl});
  @override
  Future<WeatherFiveDaysWithThreeHourModel?> getWeatherData({required String unit}) async {
    if (_longitude != null && _latitude != null) {
      var evolvedUrl = "$_baseUrl/forecast?lat=$_latitude&lon=$_longitude&lang=tr&appid=$_apiKey";
      final response = await http.get(Uri.parse(getApiUrl(tempUnit: unit, evolvedUrl: evolvedUrl)));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        if (decodedData != null) {
          return WeatherFiveDaysWithThreeHourModel.fromJson(decodedData);
        }
      }
    }
    print(unit);
    return null;
  }
}

class CityWeatherService {
  final String _apiKey;
  final String _baseUrl;

  CityWeatherService({required String apiKey, required String baseUrl})
      : _apiKey = apiKey,
        _baseUrl = baseUrl;

  String getApiUrl({required String tempUnit, required String evolvedUrl}) {
    String units = tempUnit.toLowerCase();
    if (tempUnit == TemperatureUnit.Default.name) {
      return evolvedUrl;
    }
    return "$evolvedUrl&units=$units";
  }

  Future<WeatherModel?> getCityWeatherData(String? cityName,{required String unit}) async {
    if (cityName != null) {
      var evolvedUrl = "$_baseUrl/weather?q=$cityName&lang=tr&appid=$_apiKey";
      final response = await http.get(Uri.parse(getApiUrl(tempUnit: unit, evolvedUrl: evolvedUrl)));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      }
    }
    print(unit);
    return null;
  }
}


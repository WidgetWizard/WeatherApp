import 'package:flutter/material.dart';
import '../model/weather_model.dart';
import '../product/api/project_api.dart';
import '../service/weather_service.dart';
import '../view/weather_page_view.dart';

abstract class WeatherPageViewModel extends State<WeatherPageView>{
  final String _weatherApiKey = ProjectApi().getWeatherApi;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5";
  final String randomImageUrl = 'https://api.api-ninjas.com/v1/randomimage?category=nature';
  bool isLoading = false;
  late final IWeatherService _weatherService;
  WeatherModel? weatherModel;
  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService(apiKey: _weatherApiKey, baseUrl: _baseUrl);
    init().then((weather) {
      print(weather?.cityName);
    });
  }
  Future<WeatherModel?> init() async {
    setState(() => isLoading = true);
    await _weatherService.getLocationWithPermission();
    WeatherModel? weather = await _weatherService.getWeatherData();
    setState(() {
      weatherModel = weather;
      isLoading = false;
    });
    return weather;
  }

}
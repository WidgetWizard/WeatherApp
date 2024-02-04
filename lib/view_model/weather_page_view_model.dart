import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/service/background_image_service.dart';
import '../model/weather_model.dart';
import '../product/api/project_api.dart';
import '../service/notification_service.dart';
import '../service/weather_service.dart';
import '../view/weather_page_view.dart';

abstract class WeatherPageViewModel extends State<WeatherPageView>{
  final String _weatherApiKey = ProjectApi().getWeatherApi;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5";
  final String randomImageUrl = RandomBackgroundImage().url;
  Timer? _timer;
  late final IWeatherService _weatherService;
  WeatherModel? weatherModel;
  late final NotificationService notificationService;
  late Future<void> initBackgroundImageAndWeatherFuture;

  @override
  void initState() {
    super.initState();
    initBackgroundImageAndWeatherFuture = _initBackgroundImageAndWeather();
  }

  Future<void> _initBackgroundImageAndWeather() async {
    await initNotificationAndWeather().then((weather) {
      print(weather?.cityName);
      startPeriodicNotifications();
    });
  }

  Future<WeatherModel?> initNotificationAndWeather() async {
    notificationService = NotificationService();
    WeatherModel? weather;
    _weatherService = CurrentWeatherService(apiKey: _weatherApiKey, baseUrl: _baseUrl);
    await _weatherService.getLocationWithPermission();
    await notificationService.initializeNotification(null);
    weather = await _weatherService.getWeatherData();
    setState(() {
      weatherModel = weather;
    });
    startPeriodicNotifications();
    return weather;
  }

  void startPeriodicNotifications() { //todo:şaunda runla timersiz deniyorum
    /*_timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      showNotification();
    });*/
    showNotification();
  }

  Future<void> showNotification() async {
    await notificationService.showNotification(
        title: "${weatherModel?.cityName}",
        body: "${weatherModel?.mainCondition} ${weatherModel?.temp?.toInt()}°",
        scheduled: true,
        interval: 5,
    );
  }
/*  @override
  void dispose() {
    stopPeriodicNotifications();
    super.dispose();
  }
  void stopPeriodicNotifications() {
    _timer?.cancel();
  }*/
}


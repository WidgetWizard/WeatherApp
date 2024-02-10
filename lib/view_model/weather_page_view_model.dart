import 'dart:async';

import 'package:flutter/material.dart';
import '../model/weather_five_days_with_three_hours_model.dart';
import '../model/weather_model.dart';
import '../product/api/project_api.dart';
import '../service/background_image_service.dart';
import '../service/notification_service.dart';
import '../service/weather_service.dart';
import '../view/weather_page_view.dart';

abstract class WeatherPageViewModel extends State<WeatherPageView> {
  final String _weatherApiKey = ProjectApi().getWeatherApi;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5";
  final String randomImageUrl = RandomBackgroundImage().url;
  late Timer _timer;
  late final IWeatherService _weatherService;
  WeatherModel? weatherModel;
  late final NotificationService notificationService;
  WeatherFiveDaysWithThreeHourModel? weatherThreeHoursModel;
  late final IWeatherService _weatherThreeHoursService;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initStateForLateObjects();
    _initBackgroundImageAndWeather();
    _startTimer();
    print("weatherThreeHoursModel :${weatherThreeHoursModel?.cityName}");
  }

  Future<void> _initBackgroundImageAndWeather() async {
    setState(() {
      isLoading = true;
    });
    await initNotificationAndWeather().then((weather) {
      print(weather?.cityName);
      setState(() {
        weatherModel = weather;
        isLoading = false;
      });
    });
  }

  void _initStateForLateObjects(){
    notificationService = NotificationService();
    _weatherService = CurrentWeatherService(apiKey: _weatherApiKey, baseUrl: _baseUrl);
    _weatherThreeHoursService = WeatherServiceForFiveDaysWithThreeHours(apiKey: _weatherApiKey, baseUrl: _baseUrl);
  }

  Future<WeatherModel?> initNotificationAndWeather() async {
    //todo: initFiveDaysThreeHoursWeatherData i initNotificationAndWeather den ayrı calısıp calısmadıgını dene
    WeatherModel? weather;
    await _weatherService.getLocationWithPermission();
    await notificationService.initializeNotification(null);
    weather = await _weatherService.getWeatherData();
    await initFiveDaysThreeHoursWeatherData().then((weather) {
      print(weather?.temp);
    });
    return weather;
  }


  Future<WeatherFiveDaysWithThreeHourModel?> initFiveDaysThreeHoursWeatherData() async {
    WeatherFiveDaysWithThreeHourModel model;
    await _weatherThreeHoursService.getLocationWithPermission();
    model = await _weatherThreeHoursService.getWeatherData();
    print("model :${model.cityName}");
    setState(() {
      weatherThreeHoursModel = model;
    });
    return model;
  }

  void _startTimer() {
    int k = 1;
    _timer = Timer.periodic(const Duration(hours: 6), (timer) {
      if (weatherThreeHoursModel != null) {
        if (k < (weatherThreeHoursModel?.mainCondition?.length ?? 0)) {
          String? mainCondition = weatherThreeHoursModel?.mainCondition?[k];
          int? temperature = weatherThreeHoursModel?.temp?[k].toInt();
          _showNotification(mainCondition,temperature);
          k += 2;
        } else {
          initFiveDaysThreeHoursWeatherData();
          print("yeni veriler geldi!");
          k = 1;
        }
      }
    });
  }


  Future<void> _showNotification(String? mainCondition,int? temperature) async {
    await notificationService.showNotification(
      title: weatherThreeHoursModel?.cityName ?? "",
      body: "Six hours later :$mainCondition $temperature°",
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

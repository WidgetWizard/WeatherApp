import 'dart:async';

import 'package:flutter/material.dart';
import '../model/weather_five_days_with_three_hours_model.dart';
import '../model/weather_model.dart';
import '../product/api/project_api.dart';
import '../product/extension/temperature_units.dart';
import '../product/global/provider/global_manage_provider.dart';
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
  late String temperatureUnit = GlobalManageProvider.globalManageCubit.state.temperatureUnit ?? TemperatureUnit.Metric.getTemperatureUnit();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    temperatureUnit = GlobalManageProvider.globalManageCubit.state.temperatureUnit ?? TemperatureUnit.Metric.getTemperatureUnit();
  }

  @override
  void initState() {
    super.initState();
    _initStateForLateObjects();
    initWeatherDatas();
    _startTimer();
    print("weatherThreeHoursModel :${weatherThreeHoursModel?.cityName}");
  }

  Future<void> initWeatherDatas() async {
    setState(() {
      isLoading = true;
    });
    await initCurrentWeatherData().then((weather) {
      print(weather?.cityName);
      setState(() {
        weatherModel = weather;
      });
    });
    await initFiveDaysThreeHoursWeatherData().then((weather) {
      print(weather?.temp);
      setState(() {
        weatherThreeHoursModel = weather;
        isLoading = false;
      });
    });
  }

  void _initStateForLateObjects() {
    _weatherService = CurrentWeatherService(apiKey: _weatherApiKey, baseUrl: _baseUrl);
    _weatherThreeHoursService = WeatherServiceForFiveDaysWithThreeHours(apiKey: _weatherApiKey, baseUrl: _baseUrl);
  }

  Future<WeatherModel?> initCurrentWeatherData() async {
    WeatherModel? weather;
    await _weatherService.getLocationWithPermission();
    weather = await _weatherService.getWeatherData(unit: temperatureUnit);
    return weather;
  }
  Future<WeatherFiveDaysWithThreeHourModel?> initFiveDaysThreeHoursWeatherData() async {
    WeatherFiveDaysWithThreeHourModel model;
    await _weatherThreeHoursService.getLocationWithPermission();
    model = await _weatherThreeHoursService.getWeatherData(unit: temperatureUnit);
    print("model :${model.cityName}");
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
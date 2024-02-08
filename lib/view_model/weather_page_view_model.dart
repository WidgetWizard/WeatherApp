import 'package:flutter/material.dart';
import '../model/weather_model.dart';
import '../product/api/project_api.dart';
import '../service/weather_service.dart';
import '../view/weather_page_view.dart';
import "../model/"

abstract class WeatherPageViewModel extends State<WeatherPageView> {
  final String _weatherApiKey = ProjectApi().getWeatherApi;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5";
  final String randomImageUrl =
      'https://api.api-ninjas.com/v1/randomimage?category=nature';
  bool isLoading = false;
  late final IWeatherService _weatherService;
  WeatherModel? weatherModel;
  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService(apiKey: _weatherApiKey, baseUrl: _baseUrl);
    initWeatherModel().then((weather) {
      print(weather?.cityName);
    });
  }

// TODO: Eğer konum izni vermezse şehir seçme sayfasına yönlendirme yapılacak.
  Future<WeatherModel?> initWeatherModel() async {
    setState(() => isLoading = true);
    await _weatherService.getLocationWithPermission();
    WeatherModel? weather = await _weatherService.getWeatherData();
    setState(() {
      weatherModel = weather;
      isLoading = false;
    });
    return weather;
  }

  Future<WeatherFiveDaysWithThreeHourModel?>
      initFiveDaysThreeHoursWeatherData() async {
    WeatherFiveDaysWithThreeHourModel model;
    _weatherThreeHoursService = WeatherServiceForFiveDaysWithThreeHours(
        apiKey: _weatherApiKey, baseUrl: _baseUrl);
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
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (weatherThreeHoursModel != null) {
        if (k < (weatherThreeHoursModel?.mainCondition?.length ?? 0)) {
          String? mainCondition = weatherThreeHoursModel?.mainCondition?[k];
          int? temperature = weatherThreeHoursModel?.temp?[k].toInt();
          _showNotification(mainCondition, temperature);
          k += 2;
        } else {
          //todo: büyük ihtimalle tekrardan istek atıp yeni verileri çekmem gerekicek
          initFiveDaysThreeHoursWeatherData();
          print("yeni veriler geldi!");
          k = 1;
        }
      }
    });
  }

  Future<void> _showNotification(
      String? mainCondition, int? temperature) async {
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

import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/service/link.dart';
import 'package:weatherapp/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //give api key
  final _weatherService = WeatherService(apiKey: API_KEY().Api);
  Weather? _weather;
  // fetch weather
  _fetchweather() async {
    // weather for current location
    final cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() => _weather = weather);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //şehir adı
          Text(_weather?.cityName ?? 'Bilinmiyor'),
          //hava durumu
          Text(_weather?.mainCondition ?? 'Bilinmiyor'),
          //sıcaklık
          Text('${_weather?.temp}C'),
        ]),
      ),
    );
  }
}

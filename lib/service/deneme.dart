import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/weather_model.dart';

class WeatherServiceDeneme{
  final String? _apiKey;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5";
  WeatherServiceDeneme({required String? apiKey}) : _apiKey = apiKey;
  double? _latitude;
  double? _longitude;
  Future<WeatherModel> getWeatherByCity({String? city}) async {
    if(_longitude != null || _longitude != null){
      final response = await http.get(Uri.parse("$_baseUrl/weather?lat=$_latitude&lon=$_longitude&appid=$_apiKey"));
      if(response.statusCode == 200){
        return WeatherModel.fromJson(jsonDecode(response.body));
      }
      else{
        throw Exception('Failed to load weather data');
      }
    }
    else{
      throw Exception("Longitude and latitude has unknown");
    }
  }
  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      _latitude = position.latitude;
      _longitude = position.longitude;
      print('Enlem: ${position.latitude}, Boylam: ${position.longitude}');
    }
  }
}

void main(){
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isLoading = false;
  late final String _apiKey;
  late final WeatherServiceDeneme weatherService;
  late WeatherModel? _weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    _apiKey = "6115faddcf9ab2b8482f888359404e88";
    weatherService =  WeatherServiceDeneme(apiKey: _apiKey);
    init();
  }
  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    try {
      await weatherService.getLocation();
      await _fetchWeatherData();
    } catch (e) {
      print('Hata: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchWeatherData() async {
    try {
      _weatherModel = await weatherService.getWeatherByCity();
      print(_weatherModel?.cityName);
    } catch (e) {
      print("Error :$e");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.green,
                  )
                : Center(
                    child: Text(_weatherModel?.cityName ?? "veri gelmedi!"),
                  )
          ],
        ),
      ),
    );
  }
}

//todo: uygun servis düzeltildi, model uygun halledildi
//todo: şimdi burdaki view_model kodlarının view ekranı ile birleştiricem!
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService{
  final String? _apiKey;
  final String? baseUrl = "https://api.openweathermap.org/data/2.5";
  WeatherService({required String? apiKey}) : _apiKey = apiKey;
  double? _latitude;
  double? _longitude;

  Future<Map<String, dynamic>> getWeatherByCity({String? city}) async {
    // final response = await http.get(Uri.parse("$baseUrl/weather?lat=44.34&lon=10.99&appid=$_apiKey"));
    if(_longitude != null || _longitude != null){
      final response = await http.get(Uri.parse("$baseUrl/weather?lat=$_latitude&lon=$_longitude&appid=$_apiKey"));
      if(response.statusCode == 200){
        return json.decode(response.body);
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

/*void main() async {
const apiKey = '6115faddcf9ab2b8482f888359404e88';
const city = 'London';

WeatherService weatherService = WeatherService(apiKey: apiKey);

try {
  weatherService.getLocation();
  Map<String, dynamic> weatherData = await weatherService.getWeatherByCity(city);
  print(weatherData);
} catch (e) {
  print('Hata: $e');
}
}*/


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
  late final WeatherService weatherService;
  late Map<String, dynamic> weatherData = {};
  @override
  void initState() {
    super.initState();
    _apiKey = "6115faddcf9ab2b8482f888359404e88";
    weatherService =  WeatherService(apiKey: _apiKey);
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
    Map<String, dynamic> fetchedData;
    try {
      fetchedData = await weatherService.getWeatherByCity();
    } catch (e) {
      fetchedData = {'error': 'Failed to fetch weather data'};
    }
    setState(() {
      weatherData = fetchedData;
    });
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
                    child: Text("$weatherData"),
                  )
          ],
        ),
      ),
    );
  }
}

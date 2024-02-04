import 'package:flutter/material.dart';

import '../model/weather_five_days_with_three_hours_model.dart';
import '../product/api/project_api.dart';
import '../service/weather_service.dart';

class TestUiWeatherServiceFiveDaysWithThreeHoursView extends StatefulWidget {
  const TestUiWeatherServiceFiveDaysWithThreeHoursView({super.key});

  @override
  State<TestUiWeatherServiceFiveDaysWithThreeHoursView> createState() => _TestUiWeatherServiceFiveDaysWithThreeHoursViewState();
}

class _TestUiWeatherServiceFiveDaysWithThreeHoursViewState extends State<TestUiWeatherServiceFiveDaysWithThreeHoursView> {
  final String _weatherApiKey = ProjectApi().getWeatherApi;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5";
  late final IWeatherService _weatherService;
  WeatherFiveDaysWithThreeHourModel? weatherModel;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _weatherService = WeatherServiceForFiveDaysWithThreeHours(apiKey: _weatherApiKey, baseUrl: _baseUrl);
    fetchData();
  }

  Future<void> fetchData() async {
    await _weatherService.getLocationWithPermission();
    weatherModel = await _weatherService.getWeatherData();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (weatherModel == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Veri geldiyse, güncel hava durumu ve 5 günlük tahminleri gösterin
      return ListView(
        children: [
          _buildDivider(),
          _buildFiveDaysWeather(),
        ],
      );
    }
  }

  Widget _buildFiveDaysWeather() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '5 Days Weather Forecast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('${weatherModel?.cityName}'),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: weatherModel?.temp?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Temperature: ${weatherModel?.temp?[index]}°C'),
                  subtitle: Text('Condition: ${weatherModel?.descCondition?[index]}'),
                  // Diğer bilgileri ekleyebilirsiniz
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 20,
      thickness: 2,
    );
  }
}

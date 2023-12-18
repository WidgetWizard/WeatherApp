import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/product/api/weather_api.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/icon_size.dart';
import 'package:weatherapp/product/extension/context/padding.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/service/weather_service.dart';

import '../product/widgets/value_container.dart';

class WeatherPageView extends StatefulWidget {
  const WeatherPageView({super.key});

  @override
  State<WeatherPageView> createState() => _WeatherPageViewState();
}

class _WeatherPageViewState extends State<WeatherPageView> with _PageUtility {
  final String _weatherApiKey = WeatherApi().getWeatherApi;
  final String _baseUrl = "https://api.openweathermap.org/data/2.5";
  bool isLoading = false;
  late final IWeatherService _weatherService;
  WeatherModel? _weatherModel;
  @override
  void initState() {
    _weatherService = WeatherService(apiKey: _weatherApiKey, baseUrl: _baseUrl);
    _weatherModel = WeatherModel();
    super.initState();
  }

  Future<void> init() async {
    setState(() => isLoading = true);
    await _weatherService.getLocationWithPermission();
    await fetchWeatherData();
    setState(() => isLoading = false);
  }

  Future<void> fetchWeatherData() async {
    setState(
        () async => _weatherModel = await _weatherService.getWeatherData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              'https://api.api-ninjas.com/v1/randomimage?category=nature',
              headers: const {
                'X-Api-Key': 'Ik8iNnAkNgZuKsaXhRkWLw==bGfS6seX4Y5LttQU',
                'Accept': 'image/jpg',
              },
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  iconSize: context.iconSize.normal,
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.search_outlined)),
              actions: [
                IconButton(
                    iconSize: context.iconSize.large,
                    color: Colors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.drag_handle_outlined))
              ],
            ),
            body: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : Padding(
                    padding: context.padding.mediumSymmetricHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cityText(context),
                        _dateText(context),
                        _degreeText(context),
                        _assetsAndWeatherInfoText(context),
                        _divider(context),
                        _bottomComponent(context)
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

mixin _PageUtility {
  Padding _bottomComponent(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueContainer(valueName: "Wind", percent: 58),
          ValueContainer(valueName: "Rain", percent: 70, isPercentage: false),
          ValueContainer(
              valueName: "Humidity", percent: 92, isPercentage: false),
        ],
      ),
    );
  }

  Padding _divider(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: const Divider(color: Colors.white),
    );
  }

  Padding _assetsAndWeatherInfoText(BuildContext context) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.padding.rightOnlyNormal,
            child: Image.asset("assets/images/rainy.gif"),
          ),
          Text(
            'Raining',
            style: context.general.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: context.sized.dynamicHeigth(0.037),
            ),
          ),
        ],
      ),
    );
  }

  Padding _degreeText(BuildContext context) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.15),
      child: Text(
        '8°',
        style: context.general.textTheme.displayLarge?.copyWith(
          color: Colors.white,
          fontSize: context.sized.dynamicHeigth(0.16),
        ),
      ),
    );
  }

  Text _dateText(BuildContext context) {
    return Text(
      'Saturday 25 Jul 2020',
      style: context.general.textTheme.titleMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Padding _cityText(BuildContext context) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.1),
      child: Text(
        'Şehir ismi',
        style: context.general.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

enum WeatherCondition {
  windy,
  sunny,
  stormy,
  snowy,
  rainy,
  partsCloudy,
  haze,
}

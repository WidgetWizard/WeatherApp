import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/product/extension/context/general.dart';
import 'package:weatherapp/product/extension/context/icon_size.dart';
import 'package:weatherapp/product/extension/context/padding.dart';
import 'package:weatherapp/product/extension/context/size.dart';
import 'package:weatherapp/service/weather_service.dart';

import '../product/widgets/value_container.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> with _PageUtility{
  final _weatherService = WeatherService(apiKey: 'a83184836912e8c9215c7b7c8cecb56d');
  Weather? _weather;
  _fetchWeather() async {
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
    _fetchWeather();
    _weather?.cityName ?? "London";
    print(_weather?.cityName);
    print(_weather?.cityName);
    print(_weather?.temp);
    print(_weather?.mainCondition);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network("https://api.api-ninjas.com/v1/randomimage?category=nature"),
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(iconSize: context.iconSize.normal,color: Colors.white,
                  onPressed: () {}, icon: const Icon(Icons.search_outlined)),
              actions: [
                IconButton(iconSize: context.iconSize.large,color: Colors.white,
                    onPressed: () {}, icon: const Icon(Icons.drag_handle_outlined))
              ],
            ),
            body: Padding(
              padding: context.padding.mediumSymmetricHorizontal,
              child:  SafeArea(
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
            )
        ),
      ],
    );
  }
}

mixin _PageUtility{
  Padding _bottomComponent(BuildContext context) {
    return Padding(
      padding: context.padding.topOnlyMedium,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueContainer(valueName: "Wind",percent: 58),
          ValueContainer(valueName: "Rain",percent: 70,isPercentage: false),
          ValueContainer(valueName: "Humidity",percent: 92,isPercentage: false),
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
          Text('Raining',style: context.general.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontSize: context.sized.dynamicHeigth(0.037),
          ),),
        ],
      ),
    );
  }
  Padding _degreeText(BuildContext context) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.15),
      child: Text('8°',style: context.general.textTheme.displayLarge?.copyWith(
        color: Colors.white,
        fontSize: context.sized.dynamicHeigth(0.16),
      ),),
    );
  }
  Text _dateText(BuildContext context) {
    return Text('Saturday 25 Jul 2020',style: context.general.textTheme.titleMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),);
  }
  Padding _cityText(BuildContext context) {
    return Padding(
      padding: context.padding.dynamicOnly(top: 0.1),
      child: Text('Şehir ismi',style: context.general.textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),),
    );
  }
}

enum WeatherCondition{
  windy,
  sunny,
  stormy,
  snowy,
  rainy,
  partsCloudy,
  haze,
}

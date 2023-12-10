
import 'package:weatherapp/view/weather_page_view.dart';

extension WeatherConditionExtension on WeatherCondition{
  String getWeatherCondition(){
    switch(this){
      case WeatherCondition.windy:
      case WeatherCondition.sunny:
      case WeatherCondition.stormy:
      case WeatherCondition.snowy:
      case WeatherCondition.rainy:
      case WeatherCondition.haze:
        return "$name.gif";
      case WeatherCondition.partsCloudy:
        return "parts_cloudy.gif";
    }
  }
}
import '../../model/weather_model.dart';

enum WeatherCondition {
  wind,
  clear,
  thunderStorm,
  snow,
  rain,
  clouds,
  haze,
}

extension WeatherConditionExtension on WeatherCondition {
  static WeatherCondition? getConditionFromName(String name) {
    for (var condition in WeatherCondition.values) {
      if (condition.name.toLowerCase() == name.toLowerCase()) {
        return condition;
      }
    }
    return null;
  }

  String? getWeatherConditionGif(WeatherModel? weatherModel) {
    if (weatherModel?.mainCondition != null) {
      var condition = getConditionFromName(weatherModel!.mainCondition ?? "");
      if (condition != null) {
        return "assets/images/${condition.name}.gif";
      }
    }
    return null;
  }
}
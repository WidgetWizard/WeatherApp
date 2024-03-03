
import 'package:weatherapp/product/extension/string_extension.dart';

enum WeatherParameters{
  wind,
  humidity,
  rain
}

extension WeatherParametersExtension on WeatherParameters{
  double getWeatherParametersPercent(double? percent){
    switch(this){
      case WeatherParameters.wind:
        return (percent ?? 0) / 100 ;
      case WeatherParameters.humidity:
        return (percent ?? 0) / 100;
      case WeatherParameters.rain:
        return (percent ?? 0) / 10000;
    }
  }
  String get capitalizeValue {
    return this.toString().split('.').last.capitalizeFirstLetter()!;
  }
}
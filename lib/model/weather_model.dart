import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  late final String? cityName;
  final double? temp;
  final String? mainCondition;
  final String? descCondition;
  final double? wind;
  final int? humidity;
  final double? rain;

  WeatherModel(
      {this.cityName,
      this.temp,
      this.mainCondition,
      this.descCondition,
      this.wind,
      this.humidity,
      this.rain});


  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] + ',' + json['sys']['country'],
      temp: (json['main']['temp']),
      mainCondition: json['weather'][0]['main'],
      descCondition: json['weather'][0]['description'],
      wind: (json['wind']['speed']),
      humidity: json['main']['humidity'],
      rain: (json['rain'] != null && json['rain']['1h'] != null ? json['rain']['1h'] : null),
    );
  }
}
/*
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }
*/

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
    return _$WeatherModelFromJson(json);
  }
}

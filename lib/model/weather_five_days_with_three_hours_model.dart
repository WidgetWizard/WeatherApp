
import 'package:json_annotation/json_annotation.dart';
part 'weather_five_days_with_three_hours_model.g.dart';

@JsonSerializable()
class WeatherFiveDaysWithThreeHourModel {
  late final String? cityName;
  final List<double>? temp;
  late final List<double>? tempFeelsLike;
  final List<double>? tempMin;
  final List<double>? tempMax;
  final List<String>? mainCondition;
  final List<String>? descCondition;
  final List<double>? wind;
  final List<int>? humidity;
  final List<double>? rain;

  WeatherFiveDaysWithThreeHourModel(
      {this.cityName,
        this.temp,
        this.tempFeelsLike,
        this.tempMin,
        this.tempMax,
        this.mainCondition,
        this.descCondition,
        this.wind,
        this.humidity,
        this.rain});

  factory WeatherFiveDaysWithThreeHourModel.fromJson(Map<String,dynamic> json){
    return _$WeatherFiveDaysWithThreeHourModelFromJson(json);
  }
}


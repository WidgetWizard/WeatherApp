// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_five_days_with_three_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherFiveDaysWithThreeHourModel _$WeatherFiveDaysWithThreeHourModelFromJson(
        Map<String, dynamic> json) =>
    WeatherFiveDaysWithThreeHourModel(
          cityName: json["city"]["name"] as String?,
          temp: (json["list"] as List<dynamic>?)
              ?.map((item) => (item["main"]["temp"] as num).toDouble())
              .toList(),
          tempFeelsLike: (json["list"] as List<dynamic>?)
              ?.map((item) => (item["main"]["feels_like"] as num).toDouble())
              .toList(),
          tempMin: (json["list"] as List<dynamic>?)
              ?.map((item) => (item["main"]["temp_min"] as num).toDouble())
              .toList(),
          tempMax: (json["list"] as List<dynamic>?)
              ?.map((item) => (item["main"]["temp_max"] as num).toDouble())
              .toList(),
          mainCondition: (json["list"] as List<dynamic>?)
              ?.map((item) => item["weather"][0]["main"] as String)
              .toList(),
          descCondition: (json["list"] as List<dynamic>?)
              ?.map((item) => item["weather"][0]["description"] as String)
              .toList(),
          wind: (json["list"] as List<dynamic>?)
              ?.map((item) => (item["wind"]["speed"] as num).toDouble())
              .toList(),
          humidity: (json["list"] as List<dynamic>?)
              ?.map((item) => item["main"]["humidity"] as int)
              .toList(),
          rain: (json["list"] as List<dynamic>?)
              ?.map((item) => item.containsKey("rain") ? (item["rain"]["3h"] as num).toDouble() : 0.0)
              .toList(),
    );

Map<String, dynamic> _$WeatherFiveDaysWithThreeHourModelToJson(
        WeatherFiveDaysWithThreeHourModel instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'temp': instance.temp,
      'tempFeelsLike': instance.tempFeelsLike,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'mainCondition': instance.mainCondition,
      'descCondition': instance.descCondition,
      'wind': instance.wind,
      'humidity': instance.humidity,
      'rain': instance.rain,
    };

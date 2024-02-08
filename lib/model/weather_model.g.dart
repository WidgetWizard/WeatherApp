// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      cityName: json['name'] + ',' + json['sys']['country'] as String?,
      temp: (json['main']['temp'] as num?)?.toDouble(),
      mainCondition: json['weather'][0]['main'] as String?,
      descCondition: json['weather'][0]['description'] as String?,
      wind: (json['wind']['speed'] as num?)?.toDouble(),
      humidity: json['main']['humidity'] as int?,
      rain: (json['rain'] != null ? json['rain']['1h'] : null as num?)?.toDouble(),
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
          'cityName': instance.cityName,
          'temp': instance.temp,
          'mainCondition': instance.mainCondition,
          'descCondition': instance.descCondition,
          'wind': instance.wind,
          'humidity': instance.humidity,
          'rain': instance.rain,
    };

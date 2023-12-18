// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      cityName: json['name'] + ',' + json['sys']['country'],
      temp: json['main']['temp'],
      mainCondition: json['weather'][0]['main'],
      descCondition: json['weather'][0]['description'],
      wind: json['wind']['speed'],
      humidity: json['main']['humidity'],
      rain: json['rain'] != null ? json['rain']['1h'] : null,
);

/*
WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      cityName: json['cityName'] as String?,
      temp: (json['temp'] as num?)?.toDouble(),
      mainCondition: json['mainCondition'] as String?,
      descCondition: json['descCondition'] as String?,
      wind: (json['wind'] as num?)?.toDouble(),
      humidity: json['humidity'] as int?,
      rain: (json['rain'] as num?)?.toDouble(),
    );
*/

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

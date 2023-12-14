class Weather {
  late final String cityName;
  final double temp;
  final String mainCondition;
  final String descCondition;
  final String wind;
  final String humidity;
  final String rain;

  Weather(
      {required this.cityName,
      required this.temp,
      required this.mainCondition,
      required this.descCondition,
      required this.wind,
      required this.humidity,
      required this.rain});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'] + ',' + json['sys']['country'],
        temp: json['main']['temp'],
        mainCondition: json['weather'][0]['main'],
        descCondition: json['weather'][0]['description'],
        wind: json['wind']['speed'],
        humidity: json['main']['humidity'],
        rain: json['rain'] != null ? json['rain']['1h'] : '0');
  }
}

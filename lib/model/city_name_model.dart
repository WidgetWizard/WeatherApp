class CityNameModel {
  final String? cityName;

  CityNameModel({this.cityName});

  factory CityNameModel.fromJson(Map<String, dynamic> json) {
    return CityNameModel(
      cityName: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
    };
  }
}

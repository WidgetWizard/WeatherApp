import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/city_name_model.dart';

Future<List<CityNameModel>> fetchCityName(String query) async {
  final response = await http
      .get(Uri.parse('https://widgetwizard.github.io/miniAPI/name_city.json'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<CityNameModel> cityName = List.empty(growable: true);
    data.forEach((element) {
      var cityNameModel = CityNameModel.fromJson(element);
      if (cityNameModel.cityName!.toLowerCase().contains(query.toLowerCase())) {
        cityName.add(cityNameModel);
      }
    });

    return cityName;
  } else {
    throw Exception('Failed to load data');
  }
}

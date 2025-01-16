import 'package:http/http.dart' as http;
import 'dart:convert';
import 'WeatherModel.dart';

class Weatherapiservice {
  String apiKey = "c750c7563bb7b5b9dc9d0be31acd1015";
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  Future<WeatherModel> fetchWeatherData(String cityName) async {
    final url = "$baseUrl?q=$cityName&appid=$apiKey&units=metric";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}

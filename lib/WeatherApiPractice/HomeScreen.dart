import 'package:flutter/material.dart';

import 'WeatherApiService.dart';
import 'WeatherModel.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  final Weatherapiservice _weatherService = Weatherapiservice();
  WeatherModel? _weather;
  bool _isLoading = false;
  String _errorMessage = "";

  void _getWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      final weather = await _weatherService.fetchWeatherData(_cityController.text);
      setState(() {
        _weather = weather;
        debugPrint("fetched api weather is : $_weather");
      });
    } catch (error) {
      setState(() {
        _errorMessage = "Could not fetch weather data. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'Enter City Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _getWeather,
            child: const Text('Get Weather'),
          ),
          const SizedBox(height: 20),
          if (_isLoading) const CircularProgressIndicator(),
          if (_errorMessage.isNotEmpty)
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            if (_weather != null) ...[
              Text(
                '${_weather!.name}, ${_weather!.sys?.country}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Temperature: ${_weather!.main?.temp?.toStringAsFixed(2)}°C',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Weather: ${_weather!.weather?.first.description}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Wind Speed: ${_weather!.wind?.speed} m/s',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Humidity: ${_weather!.main?.humidity}%',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

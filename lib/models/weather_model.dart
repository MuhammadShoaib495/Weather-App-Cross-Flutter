import 'dart:convert';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final int currentPressure;
  final double currentWindSpeed;
  final int currentHumidity;
  final List<String> hourlySky; // List of hourly sky conditions
  final List<double> hourlyTemp; // List of hourly temperatures
  final List<String> dateTime; // List of date and time strings

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlySky,
    required this.hourlyTemp,
    required this.dateTime,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0]; // Current weather data
    List<String> hourlySky = [];
    List<double> hourlyTemp = [];
    List<String> dateTime = [];

    // Loop through the forecast data
    for (int i = 0; i < map['list'].length; i++) {
      final futureWeatherData = map['list'][i];
      hourlySky.add(futureWeatherData['weather'][0]['main']);
      hourlyTemp.add(futureWeatherData['main']['temp'].toDouble());

      dateTime.add(futureWeatherData['dt_txt']);
    }

    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'].toDouble(),
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'],
      currentWindSpeed: currentWeatherData['wind']['speed'].toDouble(),
      currentHumidity: currentWeatherData['main']['humidity'],
      hourlySky: hourlySky,
      hourlyTemp: hourlyTemp,
      dateTime: dateTime,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlySky': hourlySky,
      'hourlyTemp': hourlyTemp,
      'dateTime': dateTime,
    };
  }
}

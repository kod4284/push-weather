import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String _getWeatherUrl(double lat, double long) {
  String weatherUrl = 'https://api.weatherapi.com/v1/forecast.json?key='
      +dotenv.env['WEATHER_API_KEY']!
      +'&q='+lat.toString()+','+long.toString()
      +'&days=1&aqi=no&alerts=no';
  return weatherUrl;
}

class Api {
  static Future<WeatherInfo> fetchWeatherInfo(double lat, double long) async {
    final response = await http
        .get(Uri.parse(_getWeatherUrl(lat, long)));
    if (response.statusCode == 200) {
      return WeatherInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather info');
    }
  }
}

class WeatherInfo{
    final String name;
    final String lastUpdated;
    final double tempC;
    final double tempF;
    final double minTempC;
    final double minTempF;
    final double maxTempC;
    final double maxTempF;
    final double feelsLikeC;
    final double feelsLikeF;
    final String icon;
    final int chanceOfRain;
    final int willItRain;
    final int chanceOfSnow;
    final int willItSnow;
    final int humidity;

    const WeatherInfo({
      required this.name,
      required this.lastUpdated,
      required this.tempC,
      required this.tempF,
      required this.minTempC,
      required this.minTempF,
      required this.maxTempC,
      required this.maxTempF,
      required this.feelsLikeC,
      required this.feelsLikeF,
      required this.icon,
      required this.chanceOfRain,
      required this.chanceOfSnow,
      required this.humidity,
      required this.willItRain,
      required this.willItSnow
    });

    factory WeatherInfo.fromJson(Map<String, dynamic> json) {
      return WeatherInfo(
        name: json['location']['name'],
        lastUpdated: json['current']['last_updated'],
        tempC: json['current']['temp_c'],
        tempF: json['current']['temp_f'],
        feelsLikeC: json['current']['feelslike_c'],
        feelsLikeF: json['current']['feelslike_f'],
        icon: json['current']['condition']['icon'],
        humidity: json['current']['humidity'],
        minTempC: json['forecast']['forecastday'][0]['day']['mintemp_c'],
        minTempF: json['forecast']['forecastday'][0]['day']['mintemp_f'],
        maxTempC: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
        maxTempF: json['forecast']['forecastday'][0]['day']['maxtemp_f'],
        willItRain: json['forecast']['forecastday'][0]['day']['daily_will_it_rain'],
        chanceOfRain: json['forecast']['forecastday'][0]['day']['daily_chance_of_rain'],
        willItSnow: json['forecast']['forecastday'][0]['day']['daily_will_it_snow'],
        chanceOfSnow: json['forecast']['forecastday'][0]['day']['daily_chance_of_snow'],
      );
    }
}
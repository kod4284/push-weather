import 'package:flutter/material.dart';

class WeatherInfoPage extends StatefulWidget {
  const WeatherInfoPage({Key? key }) : super(key: key);
  @override
  State<WeatherInfoPage> createState() => _WeatherInfoPageState();
}

class _WeatherInfoPageState extends State<WeatherInfoPage> {
  String _location = "";
  String _tempC = "";
  String _tempF = "";
  String _feelsLikeC = "";
  String _feelsLikeF = "";
  String _lastUpdated = "";
  String _chanceOfRain = "";
  String _chanceOfSnow = "";
  String _humidity = "";
  bool _willItRain = false;
  bool _willItSnow = false;
  bool _isCelsius = false;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Location: " + _location),
          Text("Current Temp: " + (_isCelsius ? _tempC : _tempF)),
          Text("  Feels Like: " + (_isCelsius ? _feelsLikeC : _feelsLikeF)),
          Text("Status:\n"
              + (_willItRain ? "  Rain: " + _chanceOfRain + "%" : "")
              + (_willItSnow ? "  Snow: " + _chanceOfSnow + "%": "")),
          Text("Humidity: " + _humidity),
          Text("Last Updated: " + _lastUpdated),
        ],
      ),
    );
  }
}

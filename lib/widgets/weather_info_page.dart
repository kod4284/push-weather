import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '/utils/functions.dart';
import '/utils/api.dart';

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
  late Future<WeatherInfo> futureWeatherInfo;

  @override
  void initState() {
    super.initState();
    futureWeatherInfo = () async {
      Position position = await Functions.determinePosition();
      print(position);
      return await Api.fetchWeatherInfo(position.latitude, position.longitude);
    }();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<WeatherInfo>(
        future: futureWeatherInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return weatherInfoWidget(snapshot);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

Widget weatherInfoWidget (AsyncSnapshot<WeatherInfo> snapshot) {
  WeatherInfo data = snapshot.data!;
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location: " + data.name),
        const Text("* Temp"),
        Text("  Current Temp: " + (true ? data.tempC.toString() : data.tempF.toString())),
        Text("  Min Temp: " + (true ? data.minTempC.toString() : data.minTempF.toString())),
        Text("  Max Temp: " + (true ? data.maxTempC.toString() : data.maxTempF.toString())),
        Text("  Feels Like: " + (true ? data.feelsLikeC.toString() : data.feelsLikeF.toString())),
        Text("Status:\n"
            + "Chance of Rain: " + data.chanceOfRain.toString() + "%"
            + "Chance of Snow: " + data.chanceOfSnow.toString() + "%"),
        Text("Humidity: " + data.humidity.toString()),
        Text("Last Updated: " + data.lastUpdated.toString()),
      ],
    ),
  );
}

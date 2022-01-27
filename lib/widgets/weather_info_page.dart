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
  late Future<WeatherInfo> futureWeatherInfo;

  @override
  void initState() {
    super.initState();
    futureWeatherInfo = () async {
      Position position = await Functions.determinePosition();
      WeatherInfo weatherInfo = await Api.fetchWeatherInfo(position.latitude, position.longitude);
      return weatherInfo;
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 80),
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
  void refetchData() {
    setState(() {
      futureWeatherInfo = () async {
        Position position = await Functions.determinePosition();
        WeatherInfo weatherInfo = await Api.fetchWeatherInfo(position.latitude, position.longitude);
        return weatherInfo;
      }();
    });
  }
  Widget weatherInfoWidget (AsyncSnapshot<WeatherInfo> snapshot) {
    WeatherInfo data = snapshot.data!;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.tempF.toString()+'°',
                          style: const TextStyle(fontSize: 70)),
                      Row(
                        children: [
                          const Icon(Icons.room, color: Colors.blue, size: 30),
                          Text(data.name),
                        ],
                      )
                    ]),
                Image.network('https:'+data.icon)
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text("  " + data.maxTempF.toString()+'°'
                        + " / " + data.minTempF.toString()+'°'
                        + "  Feels Like " + data.feelsLikeF.toString()+'°',
                      style: const TextStyle(
                          fontSize: 15
                      ),),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.water_damage_outlined, color: Colors.blueAccent, size: 32),
                            Text(data.humidity.toString() + "%  "),
                            const Icon(Icons.beach_access,color: Colors.blue, size: 30),
                            Text(data.chanceOfRain.toString() + "%  "),
                            const Icon(Icons.ac_unit, size:28),
                            Text(data.chanceOfSnow.toString() + "%"),

                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.date_range, size:28, color: Colors.deepPurple,),
                                Text(data.lastUpdated.toString()),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left:100),
                                child: IconButton(
                                  icon: const Icon(Icons.sync),
                                  onPressed: () {
                                    setState(() {
                                      refetchData();
                                    });
                                  },
                                )
                            )
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


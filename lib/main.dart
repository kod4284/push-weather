import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/weather_info_page.dart';
import 'utils/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Push Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isSwitched = false;

  void _incrementCounter() {
    setState(() {
     _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              height: 270,
              child: const WeatherInfoPage(),
            ),
            Container(
              margin: new EdgeInsets.all(10),
              height: 250,
              child: Column(
                children:[
                  TimePickerSpinner(
                    is24HourMode: false,
                    normalTextStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.grey
                    ),
                    highlightedTextStyle: const TextStyle(
                        fontSize: 24,
                        color: Colors.black
                    ),
                    spacing: 50,
                    itemHeight: 60,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      if (isSwitched) {
                        print(time.hour);
                        print(time.minute);
                      }
                    },
                  ),
                  Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        if (value) {
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(
                            msg: "Notification On",
                          );
                        } else {
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(
                            msg: "Notification Off",
                          );
                        }
                        setState(() {
                        isSwitched = value;
                        print(isSwitched);
                        });
                      },
                    activeTrackColor: Colors.blueAccent,
                    activeColor: Colors.white,
                  )
                ]
              )
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';

import '/widgets/weather_info_page.dart';
import '/utils/notification_service.dart';
import '/feed_back.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NotificationService().init();
  await Firebase.initializeApp();
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
  bool isSwitched = false;
  int _hour = 0;
  int _minute = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              height: 370,
              child: const WeatherInfoPage(),
            ),
            Container(
              margin: EdgeInsets.all(10),
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
                      setState(() {
                        _hour = time.hour;
                        _minute = time.minute;
                      });
                      if (isSwitched) {
                        print(time.hour);
                        print(time.minute);
                        NotificationService().cancelAllNotifications();
                        NotificationService().scheduleNotifications(time.hour, time.minute);
                      }
                    },
                  ),
                  Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        if (value) {
                          Fluttertoast.cancel();
                          NotificationService().cancelAllNotifications();
                          NotificationService().scheduleNotifications(_hour, _minute);
                          Fluttertoast.showToast(
                            msg: "Notification On",
                          );
                        } else {
                          Fluttertoast.cancel();
                          NotificationService().cancelAllNotifications();
                          Fluttertoast.showToast(
                            msg: "Notification Off",
                          );
                        }
                        setState(() {
                          isSwitched = value;
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeedBackPage())
          );
        },
        tooltip: 'to Feedback page',
        child: const Icon(Icons.mail_outline),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

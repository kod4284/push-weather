import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
  NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  Future<void> init() async {

    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
    );
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

  }
  // Future selectNotification(String payload) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );
  //instance of FlutterLocalNotificationsPlugin


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  Future<void> showNotifications(String name, String temp, String chanceOfRain, String chanceOfSnow) async {
    AndroidNotificationDetails _androidNotificationDetails =  const AndroidNotificationDetails(
      '4284',
      'weather',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(
      android: _androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'In ' + name,
      temp + ' F / Rain:' + chanceOfRain + '% / Snow: ' + chanceOfSnow + '%',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
  Future<void> scheduleNotifications() async {
    AndroidNotificationDetails _androidNotificationDetails =  const AndroidNotificationDetails(
      '4284',
      'weather',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(
      android: _androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Weather notification",
        "Click here to check the weather",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
 }
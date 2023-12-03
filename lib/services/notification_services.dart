/*import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/models/task.dart';

import 'package:todo/ui/pages/notification_screen.dart';

class NotifyHelper {
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initializationNotificationsSettings() async {
    tz.initializeTimeZones();
    //tz.setLocalLocation(tz.getLocation(timeZoneName));
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('appicon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onDidReceiveNotificationResponse);
  }

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  Future<dynamic> onDidReceiveNotificationResponse(notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationScreen(paylod: payload!));
  }

  displayNotification({required Stringtitle, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  schduleNotification(int hour , int minutes , Task task ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
       0,
        '${task.title}',
        '${task.note}',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: false);
  }
}
*/
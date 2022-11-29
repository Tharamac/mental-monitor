import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class LocalNoticeService {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // static Future _notificationDetails() async => NotificationDetails(
  //   android: AndroidNotificationDetails(
  //     'channel id',
  //     'channel name',
  //     channelDescription:'channel description',
  //     importance: Importance.high
  //   ),
  //   iOS: DarwinNotificationDetails()
  // )

  Future<void> setup() async {
    // #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iosSetting =
        DarwinInitializationSettings();

    // #2
    final initSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    // #3
    await _localNotificationsPlugin
        .initialize(
      initSettings,
    )
        .then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  Future<void> showDailyNotificationAtTime(int id, String title, String body,
      String payload, TimeOfDay scheduleTime) async {
    final DateTime scheduleDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        scheduleTime.hour,
        scheduleTime.minute,
        0);
    await _localNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleDateTime,
            tz.local), //schedule the notification to show after 2 seconds.
        const NotificationDetails(
          android: AndroidNotificationDetails('main_channel', 'Main Channel',
              channelDescription: "ashwin",
              importance: Importance.max,
              priority: Priority.max),
          // iOS details
          iOS: DarwinNotificationDetails(),
        ),
        // Type of time interpretation
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle:
            true, // To show notification even when the app is closed
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future cancelNotification(int id) async {
    await _localNotificationsPlugin.cancel(id);
  }
  //   Future skipNotification(int id) async {
  //   await _localNotificationsPlugin.
  // }
}

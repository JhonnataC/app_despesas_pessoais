import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

// configura o timezone do app com o timezone local do dispositivo
  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timezoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneName));
  }

//  config de cada S.O
  Future<void> _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );
  }

  showNotification({required TimeOfDay time}) async {
    androidDetails = const AndroidNotificationDetails(
      'lembrates_notifications',
      'Lembretes diarios',
      channelDescription:
          'Canal dos lembretes para registrar gastos no aplicativo',
      icon: '@mipmap/launcher_icon',
      importance: Importance.max,
      priority: Priority.max,
    );
    localNotificationsPlugin.zonedSchedule(
      1,
      'Lembrete',
      'Não se esqueça de registrar os seus gastos!',
      scheduledTime(time),
      NotificationDetails(
        android: androidDetails,
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  tz.TZDateTime scheduledTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // final tz.TZDateTime now = tz.TZDateTime.now(tz.local).subtract(const Duration(hours: 3));

    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}

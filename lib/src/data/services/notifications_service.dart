import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationsService {
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationDetails androidDetails;
  static const String _notificationTime = 'notificationTime';
  static const String _notificationMode = 'notificationMode';

  NotificationsService() {
    _setupNotifications();
  }

// Config das notificações
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


  // Metódos de acessos dos dados salvos localmente
  static Future<void> saveNotificationTime(TimeOfDay time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final timeString =
        '2024-01-01 ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
    prefs.setString(_notificationTime, timeString);
  }

  static Future<TimeOfDay> getNotificationTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String time = prefs.getString(_notificationTime) ?? '2024-01-01 19:00:00';
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.parse(time));
    return timeOfDay;
  }

  static Future<void> changeNotificationMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final notificationMode = await getNotificationMode();
    prefs.setBool(_notificationMode, !notificationMode);
  }

  static Future<bool> getNotificationMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final notificationMode = prefs.getBool(_notificationMode) ?? true;
    return notificationMode;
  }
}



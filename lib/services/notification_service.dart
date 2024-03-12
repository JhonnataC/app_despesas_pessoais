import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:projeto_despesas_pessoais/models/notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    // await _initializeNotifications();
  }

// configura o timezone do app com o timezone local do dispositivo
  _setupTimezone() async {
    tz.initializeTimeZones();
    final String timezoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneName));
  }

//  config de cada S.O
  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );
  }

  // _onSelectNotification(String? payload) {
  //   if (payload != null && payload.isNotEmpty) {
  //     Navigator.of(AppRoutes.navigatorKey!.currentContext!).pushNamed(payload);
  //   }
  // }

  showNotification(Notifications notification) {
    androidDetails = const AndroidNotificationDetails(
      'lembrates_notifications',
      'Lembretes',
      channelDescription:
          'Canal dos lembretes para registrar gastos no aplicativo',
      importance: Importance.max,
      priority: Priority.max,
    );

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
    );
  }

  // checkForNotification() async {
  //   final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
  //   if (details!=null && details.didNotificationLaunchApp) {
  //     _onSelectNotification(details.payload);
  //   }
  // }

}

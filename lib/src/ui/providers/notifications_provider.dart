import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/data/services/notifications_service.dart';

class NotificationsProvider with ChangeNotifier {
  TimeOfDay notificationTime = const TimeOfDay(hour: 19, minute: 00);
  bool notificationIsOn = true;

  Future<void> changeNotificationMode() async {
    await NotificationsService.changeNotificationMode();
    notificationIsOn = !notificationIsOn;
    notifyListeners();
  }

  Future<void> loadNotificationMode() async {
    notificationIsOn = await NotificationsService.getNotificationMode();
    notifyListeners();
  }

  Future<void> saveNotificationTime(TimeOfDay time) async {
    await NotificationsService.saveNotificationTime(time);
    notificationTime = time;
    notifyListeners();
  }

  Future<void> loadNotificationTime() async {
    notificationTime = await NotificationsService.getNotificationTime();
    notifyListeners();
  }
}
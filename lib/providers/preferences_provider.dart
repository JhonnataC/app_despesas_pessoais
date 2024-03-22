import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/data/preferences_storage.dart';

class PreferencesProvider with ChangeNotifier {
  TimeOfDay notificationTime = const TimeOfDay(hour: 19, minute: 00);
  bool notificationIsOn = true;
  bool darkThemeIsOn = false;
  bool introScreenOn = true;

  Future<void> changeNotificationMode() async {
    await PreferencesStorage.changeNotificationMode();
    notificationIsOn = !notificationIsOn;
    notifyListeners();
  }

  Future<void> loadNotificationMode() async {
    notificationIsOn = await PreferencesStorage.getNotificationMode();
    notifyListeners();
  }

  Future<void> saveNotificationTime(TimeOfDay time) async {
    await PreferencesStorage.saveNotificationTime(time);
    notificationTime = time;
    notifyListeners();
  }

  Future<void> loadNotificationTime() async {
    notificationTime = await PreferencesStorage.getNotificationTime();
    notifyListeners();
  }

  void changeTheme() async {
    await PreferencesStorage.changeModePreference();
    darkThemeIsOn = !darkThemeIsOn;
    notifyListeners();
  }

  Future<void> loadTheme() async {
    darkThemeIsOn = await PreferencesStorage.getModePreference();
    notifyListeners();
  }

  void turnOffIntroScreen() {
    PreferencesStorage.turnOffIntroScreen();
  }

  Future<void> loadIntro() async {
    introScreenOn = await PreferencesStorage.getIntroMode();
    notifyListeners();
  }
}

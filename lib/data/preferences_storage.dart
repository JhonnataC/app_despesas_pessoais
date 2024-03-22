import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStorage {
  static const String _theme = 'darkThemeOn';
  static const String _introScreen = 'introScreenOn';
  static const String _notificationTime = 'notificationTime';
  static const String _notificationMode = 'notificationMode';

// Tema 
  static Future<void> changeModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkThemeOn = await getModePreference();
    prefs.setBool(_theme, !darkThemeOn);
  }

  static Future<bool> getModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkThemeOn = prefs.getBool(_theme) ?? false;
    return darkThemeOn;
  }

// Tela de introdução
  static Future<bool> getIntroMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introScreenOn = prefs.getBool(_introScreen) ?? true;
    return introScreenOn;
  }

  static Future<void> turnOffIntroScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_introScreen, false);
  }

// Notificações
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

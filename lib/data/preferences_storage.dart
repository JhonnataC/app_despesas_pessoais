import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStorage {
  static Future<void> changeModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkThemeOn = await loadModePreference();
    prefs.setBool('darkThemeOn', !darkThemeOn);
  }

  static Future<bool> loadModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkThemeOn = prefs.getBool('darkThemeOn') ?? false;
    return darkThemeOn;
  }

  static Future<bool> introScreenIsOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introScreenOn = prefs.getBool('introScreenOn') ?? true;
    return introScreenOn;
  } 

  static Future<void> introScreenOff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('introScreenOn', false);
  }
}

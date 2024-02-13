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
}

import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeService {
  static const String _theme = 'darkThemeOn';

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
}
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreenService {
  static const String _introScreen = 'introScreenOn';

  static Future<bool> getIntroMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introScreenOn = prefs.getBool(_introScreen) ?? true;
    return introScreenOn;
  }

  static Future<void> turnOffIntroScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_introScreen, false);
  }
}
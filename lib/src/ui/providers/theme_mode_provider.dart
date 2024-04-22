import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/data/services/theme_mode_service.dart';

class ThemeModeProvider with ChangeNotifier {
  bool darkThemeIsOn = true;

    void changeTheme() async {
    await ThemeModeService.changeModePreference();
    darkThemeIsOn = !darkThemeIsOn;
    notifyListeners();
  }

  Future<void> loadTheme() async {
    darkThemeIsOn = await ThemeModeService.getModePreference();
    notifyListeners();
  }
}
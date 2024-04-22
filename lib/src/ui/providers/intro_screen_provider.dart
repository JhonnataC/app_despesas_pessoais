import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/data/services/intro_screen_service.dart';

class IntroScreenProvider with ChangeNotifier {
  bool introScreenOn = true;

  void turnOffIntroScreen() {
    IntroScreenService.turnOffIntroScreen();
  }

  Future<void> loadIntro() async {
    introScreenOn = await IntroScreenService.getIntroMode();
    notifyListeners();
  }
}
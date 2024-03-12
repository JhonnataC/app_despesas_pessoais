// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
// import 'package:projeto_despesas_pessoais/screens/history_screen.dart';
// import 'package:projeto_despesas_pessoais/screens/home_screen.dart';
// import 'package:projeto_despesas_pessoais/screens/introduction_screen.dart';
// import 'package:projeto_despesas_pessoais/screens/month_details_screen.dart';
// import 'package:projeto_despesas_pessoais/screens/statistics_screen.dart';

class AppRoutes {
  static const INTRO_SCREEN = '/intro-screen';
  static const HOME_SCREEN = '/home-screen';
  static const STATISTICS_SCREEN = '/statistics-screen';
  static const HISTORY_SCREEN = '/history-screen';
  static const MONTH_DETAILS_SCREEN = '/month-details-screen';

  // static Map<String, Widget Function(BuildContext)> routes = {
  //   '/intro-screen': (context) => const IntroductionScreen(),
  //   '/home-screen': (context) => const HomeScreen(),
  //   '/statistics-scren': (context) => const StatisticsScreen(),
  //   '/history-screen': (context) => const HistoryScreen(),
  //   '/month-details-screen': (context) => const MonthDetailsScreen(),
  // };

  static String home = '/home-screen';

  static String introduction = '/intro-screen';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}

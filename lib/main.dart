import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_despesas_pessoais/screens/graphics_screen.dart';
import 'package:projeto_despesas_pessoais/screens/history_screen.dart';
import 'package:projeto_despesas_pessoais/screens/home_screen.dart';
import 'package:projeto_despesas_pessoais/screens/statistics_screen.dart';
import 'package:projeto_despesas_pessoais/utils/app_routes.dart';
import 'package:projeto_despesas_pessoais/utils/app_themes.dart';

void main() {
  runApp(const DespesasApp());
}

class DespesasApp extends StatefulWidget {
  const DespesasApp({super.key});

  @override
  State<DespesasApp> createState() => _DespesasAppState();
}

class _DespesasAppState extends State<DespesasApp> {
  bool darkThemeOn = false;

  void _changeTheme() {
    setState(() {
      darkThemeOn = !darkThemeOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      themeMode: darkThemeOn ? ThemeMode.dark : ThemeMode.light,
      theme: AppThemes.LIGHT_THEME,
      darkTheme: AppThemes.DARK_THEME,
      routes: {
        AppRoutes.HOME: (context) => HomeScreen(changeTheme: _changeTheme),
        AppRoutes.STATISTICS_SCREEN: (context) => const StatisticsScreen(),
        AppRoutes.GRAPHICS_SCREEN: (context) => const GraphicsScreen(),
        AppRoutes.HISTORY_SCREEN: (context) => const HistoryScreen(),
      },
    );
  }
}

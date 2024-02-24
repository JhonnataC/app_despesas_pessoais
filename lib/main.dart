import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_despesas_pessoais/data/preferences_storage.dart';
import 'package:projeto_despesas_pessoais/providers/categories_map_provider.dart';
import 'package:projeto_despesas_pessoais/providers/transactions_historic_provider.dart';
import 'package:projeto_despesas_pessoais/providers/transactions_list_provider.dart';
import 'package:projeto_despesas_pessoais/screens/graphics_screen.dart';
import 'package:projeto_despesas_pessoais/screens/history_screen.dart';
import 'package:projeto_despesas_pessoais/screens/home_screen.dart';
import 'package:projeto_despesas_pessoais/screens/month_details_screen.dart';
import 'package:projeto_despesas_pessoais/screens/statistics_screen.dart';
import 'package:projeto_despesas_pessoais/utils/app_routes.dart';
import 'package:projeto_despesas_pessoais/utils/app_themes.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void changeTheme() async {
    await PreferencesStorage.changeModePreference();
    final result = await PreferencesStorage.loadModePreference();
    setState(() {
      darkThemeOn = result;
      AppThemes.darkThemeOn = result;
    });
  }

  Future<void> loadTheme() async {
    final result = await PreferencesStorage.loadModePreference();
    setState(() {
      darkThemeOn = result;
      AppThemes.darkThemeOn = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoriesMapProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionsListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionsHistoryProvider(),
        )
      ],
      child: MaterialApp(
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
          AppRoutes.HOME: (context) => HomeScreen(changeTheme: changeTheme),
          AppRoutes.STATISTICS_SCREEN: (context) => const StatisticsScreen(),
          AppRoutes.GRAPHICS_SCREEN: (context) => const GraphicsScreen(),
          AppRoutes.HISTORY_SCREEN: (context) => const HistoryScreen(),
          AppRoutes.MONTH_DETAILS_SCREEN: (context) =>
              const MonthDetailsScreen(),
        },
      ),
    );
  }
}

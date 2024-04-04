import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_despesas_pessoais/providers/categories_map_provider.dart';
import 'package:projeto_despesas_pessoais/providers/preferences_provider.dart';
import 'package:projeto_despesas_pessoais/providers/transactions_historic_provider.dart';
import 'package:projeto_despesas_pessoais/providers/transactions_list_provider.dart';
import 'package:projeto_despesas_pessoais/screens/history_screen.dart';
import 'package:projeto_despesas_pessoais/screens/home_screen.dart';
import 'package:projeto_despesas_pessoais/screens/introduction_screen.dart';
import 'package:projeto_despesas_pessoais/screens/month_details_screen.dart';
import 'package:projeto_despesas_pessoais/screens/statistics_screen.dart';
import 'package:projeto_despesas_pessoais/services/notification_service.dart';
import 'package:projeto_despesas_pessoais/utils/app_routes.dart';
import 'package:projeto_despesas_pessoais/utils/app_themes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (context) => PreferencesProvider(),
        )
      ],
      child: const DespesasApp(),
    ),
  );
}

class DespesasApp extends StatefulWidget {
  const DespesasApp({super.key});

  @override
  State<DespesasApp> createState() => _DespesasAppState();
}

class _DespesasAppState extends State<DespesasApp> {
  @override
  void initState() {
    super.initState();
    // triggerNotification();
    loadTheme();
    loadIntro();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void triggerNotification() {
    PreferencesProvider ppProvider =
        Provider.of<PreferencesProvider>(context, listen: false);
    ppProvider.loadNotificationMode();

    if (!ppProvider.notificationIsOn) return;
    ppProvider.loadNotificationTime();
    Provider.of<NotificationService>(context, listen: false)
        .showNotification(time: ppProvider.notificationTime);
  }

  void loadTheme() {
    Provider.of<PreferencesProvider>(context, listen: false).loadTheme();
  }

  Future<void> loadIntro() async {
    Provider.of<PreferencesProvider>(context, listen: false).loadIntro();
  }

  @override
  Widget build(BuildContext context) {
    bool darkThemeIsOn =
        Provider.of<PreferencesProvider>(context).darkThemeIsOn;
    bool introScreenOn =
        Provider.of<PreferencesProvider>(context).introScreenOn;

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
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        themeMode: darkThemeIsOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppThemes.LIGHT_THEME,
        darkTheme: AppThemes.DARK_THEME,
        home: introScreenOn ? const IntroductionScreen() : const HomeScreen(),
        routes: {
          AppRoutes.INTRO_SCREEN: (context) => const IntroductionScreen(),
          AppRoutes.HOME_SCREEN: (context) => const HomeScreen(),
          AppRoutes.STATISTICS_SCREEN: (context) => const StatisticsScreen(),
          AppRoutes.HISTORY_SCREEN: (context) => const HistoryScreen(),
          AppRoutes.MONTH_DETAILS_SCREEN: (context) =>
              const MonthDetailsScreen(),
        },
        navigatorKey: AppRoutes.navigatorKey,
      ),
    );
  }
}

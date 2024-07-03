import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/intro_screen_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/notifications_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/theme_mode_provider.dart';
import 'package:projeto_despesas_pessoais/src/data/services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/categories_map_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/transactions_historic_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/transactions_list_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/screens/history_screen.dart';
import 'package:projeto_despesas_pessoais/src/ui/screens/home_screen.dart';
import 'package:projeto_despesas_pessoais/src/ui/screens/introduction_screen.dart';
import 'package:projeto_despesas_pessoais/src/ui/screens/month_details_screen.dart';
import 'package:projeto_despesas_pessoais/src/ui/screens/statistics_screen.dart';
import 'package:projeto_despesas_pessoais/src/data/utils/app_routes.dart';
import 'package:projeto_despesas_pessoais/src/data/utils/app_themes.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    triggerNotification();
    loadTheme();
    loadIntro();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void triggerNotification() {
    NotificationsProvider ntProvider =
        Provider.of<NotificationsProvider>(context, listen: false);
    ntProvider.loadNotificationMode();

    if (!ntProvider.notificationIsOn) return;

    ntProvider.loadNotificationTime();
    Provider.of<NotificationsService>(context, listen: false)
        .showNotification(time: ntProvider.notificationTime);
  }

  void loadTheme() {
    Provider.of<ThemeModeProvider>(context, listen: false).loadTheme();
  }

  Future<void> loadIntro() async {
    Provider.of<IntroScreenProvider>(context, listen: false).loadIntro();
  }

  @override
  Widget build(BuildContext context) {
    bool darkThemeIsOn = Provider.of<ThemeModeProvider>(context).darkThemeIsOn;
    bool introScreenOn =
        Provider.of<IntroScreenProvider>(context).introScreenOn;

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
      ),
    );
  }
}

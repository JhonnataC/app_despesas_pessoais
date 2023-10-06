import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_despesas_pessoais/screens/home_screen.dart';
import 'package:projeto_despesas_pessoais/utils/app_routes.dart';

void main() {
  runApp(const DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      theme: theme.copyWith(
        useMaterial3: true,
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0XFF2C2C96),
          secondary: const Color(0XFF6858E1),
          tertiary: const Color(0XFF141321),
          background: const Color(0XFFE0E3E8),
        ),
        appBarTheme: theme.appBarTheme.copyWith(
          titleTextStyle: TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: const IconThemeData(
            color: Color(0XFFE0E3E8),
          ),
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20,
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20,
            color: Colors.grey,
          ),
          bodyLarge: const TextStyle(
            fontFamily: 'Gabarito',
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
          bodyMedium: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 17,
            color: Colors.black,
          ),
          bodySmall: const TextStyle(
            fontFamily: 'Gabarito',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
      routes: {
        AppRoutes.HOME: (context) => const HomeScreen(),
      },
    );
  }
}

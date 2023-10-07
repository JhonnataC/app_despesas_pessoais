import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_despesas_pessoais/screens/home_screen.dart';
import 'package:projeto_despesas_pessoais/utils/app_routes.dart';

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
    final ThemeData lightTheme = ThemeData();
    final ThemeData darkTheme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      themeMode: darkThemeOn ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme.copyWith(
        useMaterial3: true,
        colorScheme: lightTheme.colorScheme.copyWith(
          primary: const Color(0XFF2C2C96),
          secondary: const Color(0XFF6858E1),
          tertiary: const Color(0XFF141321),
          background: const Color(0XFFE0E3E8),
        ),
        appBarTheme: lightTheme.appBarTheme.copyWith(
          titleTextStyle: TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: const IconThemeData(
            color: Color(0XFFE0E3E8),
          ),
        ),
        cardTheme: lightTheme.cardTheme.copyWith(
          color: const Color(0XFF6858E1),
          elevation: 0,
          surfaceTintColor: const Color(0XFF6858E1),
          shadowColor: Colors.white.withOpacity(0),
        ),
        textTheme: lightTheme.textTheme.copyWith(
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
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),

      // DARK THEME
      darkTheme: darkTheme.copyWith(
        useMaterial3: true,
        colorScheme: darkTheme.colorScheme.copyWith(
          primary: const Color(0XFF2C2C96),
          secondary: const Color(0XFF6858E1),
          tertiary: const Color(0XFF141321),
          background: const Color(0XFF15141B),
        ),
        appBarTheme: darkTheme.appBarTheme.copyWith(
          titleTextStyle: TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: const IconThemeData(
            color: Color(0XFFE0E3E8),
          ),
        ),
        textTheme: darkTheme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color(0XFFDCDBE1),
          ),
          titleMedium: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20,
            color: Color(0XFFDCDBE1),
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
            color: Color(0XFFDCDBE1),
          ),
          bodyMedium: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 17,
            color: Color(0XFFDCDBE1),
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

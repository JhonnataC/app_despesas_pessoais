import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_despesas_pessoais/views/home_page.dart';

void main() {
  runApp(const DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      home: const HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.black,
          secondary: const Color(0XFF03052C),
          tertiary: const Color(0XF02F3D40),
        ),
        appBarTheme: theme.appBarTheme.copyWith(
          titleTextStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'Opensans',
            fontSize: 15,
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

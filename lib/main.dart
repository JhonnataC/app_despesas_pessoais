import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/intro_screen_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/notifications_provider.dart';
import 'package:projeto_despesas_pessoais/src/ui/providers/theme_mode_provider.dart';
import 'package:projeto_despesas_pessoais/src/data/services/notifications_service.dart';
import 'package:projeto_despesas_pessoais/src/app_widget.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationsService>(
          create: (context) => NotificationsService(),
        ),
        ChangeNotifierProvider<ThemeModeProvider>(
          create: (context) => ThemeModeProvider(),
        ),
        ChangeNotifierProvider<NotificationsProvider>(
          create: (context) => NotificationsProvider(),
        ),
        ChangeNotifierProvider<IntroScreenProvider>(
          create: (context) => IntroScreenProvider(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
import 'package:flutter/material.dart';

class AppThemes {
  // ignore: non_constant_identifier_names
  static ThemeData LIGHT_THEME = ThemeData().copyWith(
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0XFF6365EE),
          secondary: const Color(0XFF0ABBCF),
          tertiary: const Color(0XFF141321),
          background: const Color(0XFFFFFFFF),
          surface: const Color(0XFFF1F2F4),
        ),
    appBarTheme: ThemeData().appBarTheme.copyWith(
          titleTextStyle: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          color: const Color(0XFF6365EE),
          iconTheme: const IconThemeData(
            color: Color(0XFFFFFFFF),
          ),
        ),
    bottomNavigationBarTheme: ThemeData().bottomNavigationBarTheme.copyWith(
          backgroundColor: const Color(0XFFF1F2F4),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
        ),
    textTheme: ThemeData().textTheme.copyWith(
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
  );
  // ignore: non_constant_identifier_names
  static ThemeData DARK_THEME = ThemeData().copyWith(
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0XFF6365EE),
          secondary: const Color(0XFF0ABBCF),
          tertiary: const Color(0XFF141321),
          background: const Color(0XFF15141B),
          surface: const Color(0XFF292C35),
        ),
    appBarTheme: ThemeData().appBarTheme.copyWith(
          titleTextStyle: const TextStyle(
            fontFamily: 'Gabarito',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          color: const Color(0XFF6365EE),
          iconTheme: const IconThemeData(
            color: Color(0XFFE0E3E8),
          ),
        ),
    bottomNavigationBarTheme: ThemeData().bottomNavigationBarTheme.copyWith(
          backgroundColor: const Color(0XFF2B2E3D),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
        ),
    textTheme: ThemeData().textTheme.copyWith(
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
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
  );
}

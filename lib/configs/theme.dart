import 'package:flutter/material.dart';

const Color textColor = Colors.black87;
double _defaultRadius = 14;
final lightTheme = ThemeData.light().copyWith(
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(const Color(0xff5746E4)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'vazir'),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_defaultRadius), // <-- Radius
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(_defaultRadius)),
        borderSide: const BorderSide(
          color: Color(0xffC4C4C4),
        ),
      ),
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: const Color(0xff5746E4),
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        background: const Color(0xfffefefe),
        onBackground: Colors.black,
        shadow: Colors.grey.withOpacity(0.2),
        surface: const Color(0xffF7F7F7),
        secondaryContainer: Colors.white,
        onSurface: Colors.black),
    textTheme: const TextTheme(
        labelSmall: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w300,
            fontSize: 14,
            fontFamily: 'vazir'),
        labelMedium: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'vazir'),
        bodySmall: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'vazir'),
        labelLarge: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            fontFamily: 'vazir')));

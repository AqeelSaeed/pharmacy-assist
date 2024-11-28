import 'dart:math';
import 'package:flutter/material.dart';

import 'palette.dart';

ThemeData themeData() {
  double globalElevation = 3.0;
  double globalBorderRadius = 10.0;

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Palette.scaffoldBackground,
    dialogTheme: DialogTheme(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(globalBorderRadius),
      ),
    ),
    fontFamily: "Nexa",
    primaryColor: Palette.primary,
    primarySwatch: _generateMaterialColor(Palette.primary),
    sliderTheme: SliderThemeData(
      inactiveTrackColor: Palette.primary.withOpacity(0.3),
      valueIndicatorTextStyle:
          const TextStyle(color: Colors.white, fontFamily: "Nexa"),
      valueIndicatorColor: Palette.primary,
    ),
    cardTheme: CardTheme(
      elevation: globalElevation,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(globalBorderRadius),
      ),
    ),
    chipTheme: ChipThemeData(
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: Palette.primary,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(globalBorderRadius)),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Palette.primary,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: "Nexa",
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Palette.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Palette.primary,
      surface: Colors.white,
    ),
  );
}

MaterialColor _generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  });
}

int _tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _tintColor(Color color, double factor) => Color.fromRGBO(
    _tintValue(color.red, factor),
    _tintValue(color.green, factor),
    _tintValue(color.blue, factor),
    1);

int _shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color _shadeColor(Color color, double factor) => Color.fromRGBO(
    _shadeValue(color.red, factor),
    _shadeValue(color.green, factor),
    _shadeValue(color.blue, factor),
    1);

const List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(-1, 1),
    blurRadius: 10,
  )
];

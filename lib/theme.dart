import 'package:flutter/material.dart';

var fontFamily = 'Finlandica';

ThemeData buildLightTheme() {
  var base = ThemeData(fontFamily: fontFamily);
  return base.copyWith(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.red[300]!,
      secondary: Colors.red[200]!,
    ),
    primaryColor: Colors.red[300]!,
    toggleableActiveColor: Colors.red[400]!,
  );
}

ThemeData buildDarkTheme() {
  var base = ThemeData.dark();

  return base.copyWith(
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: fontFamily),
    primaryTextTheme: ThemeData.dark().textTheme.apply(fontFamily: fontFamily),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: const Color(0xff723539),
      elevation: 1,
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.red[300]!,
      secondary: Colors.red[200]!,
      surface: Colors.blue[100]!,
    ),
    toggleableActiveColor: Colors.red[300]!,
  );
}

enum ThemeOption { light, dark }

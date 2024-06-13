import 'package:flutter/material.dart';

final ThemeData theme_light = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.grey,
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Colors.white,
    primaryContainer: Colors.black,
    onPrimaryContainer: Colors.white,
    secondary: Colors.white,
  ),
  // textTheme:
);

final ThemeData theme_dark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Colors.black,
    primaryContainer: Colors.white,
    onPrimaryContainer: Colors.grey[900],
    secondary: Colors.black,
  ),
  // textTheme:
);

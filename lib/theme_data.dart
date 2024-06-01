import 'package:flutter/material.dart';

final ThemeData theme_light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.amber,
);

final ThemeData theme_dark = ThemeData(
  primaryColor: Colors.orangeAccent,
  useMaterial3: true,
  brightness: Brightness.dark,
  // colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 54, 55, 67)),
);
import 'package:and_i/routes/serial_monitor.dart';
import 'package:and_i/routes/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:and_i/routes/home.dart';
import 'package:and_i/and_i/and_i.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final and_i_Port = ChangeNotifierProvider<and_i>((ref) {
  return and_i();
});

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const home(),
          '/serial_monitor': (context) => Serial_monitor(),
          '/settings': (context) => const Settings(),
        },
        title: 'And_i',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
      );
  }
}

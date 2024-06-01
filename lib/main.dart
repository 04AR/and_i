import 'package:flutter/material.dart';
import 'theme_data.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/setting_provider.dart';

import 'package:and_i/routes/home.dart';
import 'package:and_i/and_i/emoticons.dart';
import 'package:and_i/routes/serial_monitor.dart';
import 'package:and_i/routes/settings.dart';

import 'package:and_i/and_i/and_i.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final and_i_Port = ChangeNotifierProvider<and_i>((ref) {
  return and_i();
});


class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const home(),
          '/emoticons': (context) => const Emoticons(),
          '/serial_monitor': (context) => Serial_monitor(),
          '/settings': (context) => Settings(),
        },
        title: 'And_i',
        theme: isDarkMode ? theme_dark : theme_light,
      );
  }
}

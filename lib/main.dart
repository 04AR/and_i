import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_data.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/setting_provider.dart';

import 'package:and_i/routes/home.dart';
import 'package:and_i/and_i/emoticons.dart';
import 'package:and_i/routes/serial_monitor.dart';
import 'package:and_i/routes/settings.dart';

import 'package:and_i/and_i/and_i.dart';

late SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: App()));
}

class SnackBarService {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  static void showSnackBar({required String content}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(themeProvider);
    // Eager initializing and_i provider
    ref.watch(and_i_Port);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: SnackBarService.scaffoldKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const home(),
          '/emoticons': (context) => const Emoticons(),
          '/serial_monitor': (context) => serial_monitor(),
          '/settings': (context) => const Settings(),
        },
        title: 'And_i',
        theme: isDarkMode ? theme_dark : theme_light,
      );
  }
}

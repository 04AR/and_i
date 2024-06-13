import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:and_i/main.dart';
import 'package:and_i/and_i/gemini.dart';

class ThemeNotifier extends Notifier<bool> {
  // late SharedPreferences prefers;
  @override
  bool build() {
    return prefs.getBool('isdarkMode')??false;
  }

  // ThemeNotifier(){
  //   getPrefs();
  // }

  // void getPrefs() async {
  //   prefers = await SharedPreferences.getInstance();
  // }

  void toggleTheme() async {
    state = !state;
    prefs.setBool('isdarkMode', state);
  }
}

class GeminiApiNotifier extends Notifier<String> {
  @override
  String build() {
    return prefs.getString('geminiApi')??"";
  }

  void getAPI(String api) async {
    state = api;
    prefs.setString('geminiApi', api);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, bool>(() {
  return ThemeNotifier();
});

final geminiProvider = Provider((ref) {
  Gemini gemini = Gemini(ref.watch(geminiApiProvider));
  return gemini;
});

final geminiApiProvider = NotifierProvider<GeminiApiNotifier, String>(() {
  return GeminiApiNotifier();
});
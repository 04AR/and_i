import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:and_i/and_i/gemini.dart';

class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggleTheme() {
    state = !state;
  }
}

class GeminiApiNotifier extends Notifier<String>{
   @override
  String build() {
    return "";
  }

  void get_API(String api){
    state = api;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, bool>(() {
  return ThemeNotifier();
});

final geminiProvider = Provider((ref){
  Gemini gemini = Gemini(ref.watch(geminiApiProvider));
  return gemini;
});

final geminiApiProvider = NotifierProvider<GeminiApiNotifier, String>((){
  return GeminiApiNotifier();
});


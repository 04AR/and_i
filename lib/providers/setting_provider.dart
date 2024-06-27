import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:and_i/main.dart';
import 'package:and_i/and_i/and_i_Sense.dart';
import 'package:and_i/and_i/gemini.dart';

class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return prefs.getBool('isdarkMode') ?? false;
  }

  void toggleTheme() async {
    state = !state;
    prefs.setBool('isdarkMode', state);
  }
}

// [accel, gyro, magno, orient, env, loc, cam]
class SensorNotifier extends Notifier<List<bool>> {
  @override
  List<bool> build() {
    return (prefs.getStringList("senseKey") ??
            <bool>[false, false, false, false, false, false, false])
        .map((val) => val == 'true')
        .toList();
  }

  void toggleAccel() async {
    state[0] = !state[0];
    state = [...state];
    if (state[0]) {
      ref.read(sensorsProvider).initAccel();
    } else {
      ref.read(sensorsProvider).disposeAccel();
    }
    // print(state.map((val) => val.toString()).toList());
    prefs.setStringList(
        'senseKey', state.map((val) => val.toString()).toList());
  }

  void toggleGyro() async {
    state[1] = !state[1];
    state = [...state];
    if (state[1]) {
      ref.read(sensorsProvider).initGyro();
    } else {
      ref.read(sensorsProvider).disposeGyro();
    }
    prefs.setStringList(
        'senseKey', state.map((val) => val.toString()).toList());
  }

  void toggleMagno() async {
    state[2] = !state[2];
    state = [...state];
    if (state[2]) {
      ref.read(sensorsProvider).initMagno();
    } else {
      ref.read(sensorsProvider).disposeMagno();
    }
    prefs.setStringList(
        'senseKey', state.map((val) => val.toString()).toList());
  }

  void toggleOrient() async {
    state[3] = !state[3];
    state = [...state];
    if (state[3]) {
      ref.read(sensorsProvider).initOrient();
    } else {
      ref.read(sensorsProvider).disposeOrient();
    }
    prefs.setStringList(
        'senseKey', state.map((val) => val.toString()).toList());
  }

  void toggleEnv() async {
    state[4] = !state[4];
    state = [...state];
    if (state[4]) {
      ref.read(sensorsProvider).initEnv();
    } else {
      ref.read(sensorsProvider).disposeEnv();
    }
    prefs.setStringList(
        'senseKey', state.map((val) => val.toString()).toList());
  }

  void toggleLoc() async {
    state[5] = !state[5];
    state = [...state];
    prefs.setStringList(
        'senseKey', state.map((val) => val.toString()).toList());
  }

  void toggleCam() async {
    state[6] = !state[6];
    state = [...state];
    prefs.setStringList(
        'senseKey', state.map((val) => val.toString()).toList());
  }
}

class GeminiApiNotifier extends Notifier<String> {
  @override
  String build() {
    return prefs.getString('geminiApi') ?? "";
  }

  void getAPI(String api) async {
    state = api;
    prefs.setString('geminiApi', api);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, bool>(() {
  return ThemeNotifier();
});

final sensorFlagProvider = NotifierProvider<SensorNotifier, List<bool>>(() {
  return SensorNotifier();
});

final geminiProvider = Provider((ref) {
  Gemini gemini = Gemini(ref.watch(geminiApiProvider));
  return gemini;
});

final geminiApiProvider = NotifierProvider<GeminiApiNotifier, String>(() {
  return GeminiApiNotifier();
});

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:and_i/providers/setting_provider.dart';

class Emoticons extends ConsumerStatefulWidget {
  const Emoticons({super.key});

  @override
  ConsumerState<Emoticons> createState() => _EmoticonsState();
}

class _EmoticonsState extends ConsumerState<Emoticons> {
  final SpeechToText _speechToText = SpeechToText();
  // bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    // print("started");
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gemini = ref.watch(geminiProvider);

    return GestureDetector(
      onTap: _speechToText.isNotListening ? _startListening : _stopListening,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AutoSizeText(
                  "(●'◡'●)",
                  style: TextStyle(fontSize: 200),
                  maxLines: 1,
                ),
                Text(_lastWords),
                FutureBuilder<String>(
                    // initialData: "Hello",
                    future: gemini.promt(_lastWords),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("...");
                      } else if (snapshot.hasError) {
                        // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Error: ${snapshot.error}')));
                        return Text('${snapshot.error}');
                        // return Text("data");
                      } else if (snapshot.hasData) {
                        return Text('${snapshot.data}');
                      } else {
                        return const Text("");
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:and_i/providers/setting_provider.dart';
// import 'package:and_i/and_i/gemini.dart';

class Emoticons extends ConsumerStatefulWidget {
  const Emoticons({super.key});

  @override
  ConsumerState<Emoticons> createState() => _EmoticonsState();
}

class _EmoticonsState extends ConsumerState<Emoticons> {
  String emoticon = "(●'◡'●)";
  @override
  Widget build(BuildContext context) {
    final _gemini = ref.watch(geminiProvider);

    _gemini.response("list a kaomonji of sad");

    return Scaffold(
      body: Center(
          child: AutoSizeText(
                  emoticon,
                  style: const TextStyle(fontSize: 200),
                  maxLines: 1,
                )),
    );
  }
}

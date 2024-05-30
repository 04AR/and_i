import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Emote extends StatefulWidget {
  const Emote({super.key});

  @override
  State<Emote> createState() => _EmoteState();
}

class _EmoteState extends State<Emote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: AutoSizeText(
        "☆*: .｡. o(≧▽≦)o .｡.:*☆",
        style: TextStyle(fontSize: 150),
        maxLines: 1,
      )),
    );
  }
}

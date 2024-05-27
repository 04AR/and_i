import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Emote extends StatefulWidget {
  const Emote({super.key});

  @override
  State<Emote> createState() => _EmoteState();
}

class _EmoteState extends State<Emote> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SvgPicture.asset(
          'assets/svgs/Idle.svg',
          // height: MediaQuery.sizeOf(context).height * 0.7,
        ),
      ),
    );
  }
}

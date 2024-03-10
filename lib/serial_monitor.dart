import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Serial_monitor extends ConsumerWidget {
  const Serial_monitor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        Row(
          children: [
            Text("S E R I A L  M O N I T O R"),

            Text("BPS : 115200")
          ],
        ),

        Text(""),
      ],
    );
  }
}
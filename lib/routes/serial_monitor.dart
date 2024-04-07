import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Serial_monitor extends ConsumerWidget {
  const Serial_monitor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("S E R I A L   M O N I T O R")),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("BPS : ${ref.watch(and_i_Port).buad_rate}"),
            ElevatedButton.icon(
                onPressed: () {
                  ref.read(and_i_Port).Clr_Serial();
                },
                icon: const Icon(Icons.article_rounded),
                label: const Text("CLEAR"))
          ]),
          Text(ref.watch(and_i_Port).serial_data),
        ],
      ),
    );
  }
}

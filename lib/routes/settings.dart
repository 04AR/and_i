import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("S E T T I N G S")),
      body: ListView(
        children: [
          ListTile(
            title: Text("usb Port : ${ref.watch(and_i_Port).usb}")
          ),
          ListTile(
            title: Text("Baud Rate : ${ref.watch(and_i_Port).buad_rate}"),
          ),
        ],
      ),
    );
  }
}

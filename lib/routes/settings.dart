import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:and_i/providers/setting_provider.dart';
import 'package:and_i/and_i/gemini.dart';

class Settings extends ConsumerWidget {
  Settings({super.key});

  // late Gemini _geminiGPT;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    final geminikey = ref.watch(geminiApiProvider);
    final geminiNotifier = ref.read(geminiApiProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("S E T T I N G S")),
      body: ListView(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              initialValue: geminikey,
              // obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.key),
                hintText: 'Gemini API KEY',
                labelText: 'API KEY *',
              ),
              onChanged: (value) {
                geminiNotifier.get_API(value);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Theme : "),
            trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                }),
          ),
          const Divider(),
          const ListTile(
            title: Text("Language : "),
            trailing: Text("English"),
            // trailing: DropdownButton(items: [], onChanged: (){}),
          ),
          const Divider(),
          ListTile(title: Text("Usb Port : ${ref.watch(and_i_Port).usb}")),
          const Divider(),
        ],
      ),
    );
  }
}

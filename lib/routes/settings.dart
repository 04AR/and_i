import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:and_i/providers/setting_provider.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

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
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              initialValue: geminikey,
              // obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.key),
                hintText: 'API KEY',
                labelText: 'GEMINI API KEY *',
              ),
              onChanged: (value) {
                geminiNotifier.getAPI(value);
              },
            ),
          ),
          const Divider(),
          panel(
            title: "Dark Mode:",
            trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                }),
          ),
          const Divider(),
          // panel(
          //   title: "Languages",
          //   trailing: DropdownButton(
          //     onChanged: (obj) {},
          //     isExpanded: true,
          //     // value: "en",
          //     items: const [
          //       DropdownMenuItem(value: "en",child: Text("English") ,),
          //       DropdownMenuItem(value: "sp",child: Text("Spanish"),),
          //       DropdownMenuItem(value: "gr",child: Text("German"),),
          //       DropdownMenuItem(value: "jp",child: Text("Japanese"),),
          //       DropdownMenuItem(value: "ch",child: Text("Chinese"),),
          //       DropdownMenuItem(value: "kr",child: Text("Korean"),)
          //     ],
          //   ),
          // ),
          // const Divider(),
          panel(title: "Usb Port : ${ref.watch(and_i_Port).usb}"),
          const Divider(),
          panel(title: "Version: ", trailing: const Text("1.0"),),
          const Divider(),
        ],
      ),
    );
  }
}

class panel extends StatelessWidget {
  panel({super.key, this.title = "T I T L E", this.trailing});

  String title;

  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium,),
          trailing ?? Container(),
        ],
      ),
    );
  }
}

import 'package:and_i/and_i/and_i.dart';
import 'package:and_i/and_i/and_i_Sense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:and_i/providers/setting_provider.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    final _sensor_Flags = ref.watch(sensorFlagProvider);
    final _sensor_FlagsNotifier = ref.watch(sensorFlagProvider.notifier);

    final geminikey = ref.watch(geminiApiProvider);
    final geminiNotifier = ref.read(geminiApiProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("S E T T I N G S")),
      body: ListView(
        children: [
          const Divider(),
          panel(title: "G E M I N I  A P I  K E Y",),
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
          const Divider(),
          panel(title: "T H E M E ",),
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
          const Divider(),
          const panel(title: "S E N S O R S "),
          panel(
            title: "Accelerometer: ",
            trailing: Switch(
                value: _sensor_Flags[0],
                onChanged: (value) {
                  _sensor_FlagsNotifier.toggleAccel();
                }),
          ),
          panel(
            title: "Gyro: ",
            trailing: Switch(
                value: _sensor_Flags[1],
                onChanged: (value) {
                  _sensor_FlagsNotifier.toggleGyro();
                }),
          ),
          panel(
            title: "Magno: ",
            trailing: Switch(
                value: _sensor_Flags[2],
                onChanged: (value) {
                  _sensor_FlagsNotifier.toggleMagno();
                }),
          ),
          panel(
            title: "Orient: ",
            trailing: Switch(
                value: _sensor_Flags[3],
                onChanged: (value) {
                  _sensor_FlagsNotifier.toggleOrient();
                }),
          ),
          panel(
            title: "Environment Sensor: ",
            trailing: Switch(
                value: _sensor_Flags[4],
                onChanged: (value) {
                  _sensor_FlagsNotifier.toggleEnv();
                }),
          ),
          panel(
            title: "Location: ",
            trailing: Switch(
                value: _sensor_Flags[5],
                onChanged: (value) {
                  _sensor_FlagsNotifier.toggleLoc();
                }),
          ),
          panel(
            title: "Cam: ",
            trailing: Switch(
                value: _sensor_Flags[6],
                onChanged: (value) {
                 _sensor_FlagsNotifier.toggleCam();
                }),
          ),
          const Divider(),
          panel(title: "Title: ${ref.watch(and_i_Port.notifier).usb}",),
          const Divider(),
          const panel(
            title: "Version: ",
            trailing: Text("1.0"),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class panel extends StatelessWidget {
  const panel({super.key, this.title = "T I T L E", this.trailing});

  final String title;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing ?? Container(),
        ],
      ),
    );
  }
}

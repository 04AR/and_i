import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class home extends ConsumerWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("T I T L E")),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_heart),
              title: const Text('Serial Monitor'),
              onTap: () {
                Navigator.pushNamed(context, '/serial_monitor');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ref.watch(and_i_Port).usb),
            Text("x${ref.watch(sense).test_data[0]}"),
            Text("y${ref.watch(sense).test_data[1]}"),
            Text("z${ref.watch(sense).test_data[2]}"),
            ElevatedButton.icon(
                onPressed: () {
                  ref.read(sense).get_sense();
                },
                icon: const Icon(Icons.app_shortcut),
                label: const Text("get_data")),
          ],
        ),
      ),
    );
  }
}

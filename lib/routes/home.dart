import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class home extends ConsumerWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('H E A D E R'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Emoticons'),
              onTap: () {
                Navigator.pushNamed(context, '/emoticons');
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
          ],
        ),
      ),
    );
  }
}

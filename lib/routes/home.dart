import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:and_i/and_i/emoticons.dart';

class home extends ConsumerWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButtonHideUnderline(
              child: DropdownButton2(
            customButton: const Icon(Icons.more_vert_rounded,size: 30,),
            items: [
              // Menu Items
              ...MenuItems.items.map(
                (item) {
                  return DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  );
                },
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value!);
            },
            dropdownStyleData: const DropdownStyleData(
              width: 200,
            ),
          ))
        ],
      ),
      body: const Emoticons(),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  // Menu Items widget list
  static const List<MenuItem> items = [serialMonitor, camView, settings];

  static const serialMonitor = MenuItem(text: 'Serial Monitor', icon: Icons.monitor_heart);
  static const camView = MenuItem(text: "CamView", icon: Icons.camera_enhance);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.serialMonitor:
        Navigator.pushNamed(context, '/serial_monitor');
        break;
      case MenuItems.camView:
        
        SnackBarService.showSnackBar(content: "CamView");
        break;
      case MenuItems.settings:
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }
}

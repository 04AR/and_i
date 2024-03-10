import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:and_i/and_i.dart';
// import 'sensors_data.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final and_i _and_i = and_i();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'And_i',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(title: const Text("T I T L E")),
            drawer: Drawer(
              child: ListView(
                children: const [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Text('Drawer Header'),
                  ),
                  ListTile(
                    title: Text('Item 1'),
                  ),
                  ListTile(
                    title: Text('Item 2'),
                  )
                ],
              ),
            ),
            body: home()));
  }
}

class home extends ConsumerWidget {
   home({super.key});

  static final usb_data = ChangeNotifierProvider<and_i>((ref) {
    return and_i();
  });

  // static final sense = ChangeNotifierProvider<and_i_Sense>((ref) {
  //   return and_i_Sense();
  // });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          Text(ref.watch(usb_data).usb),
          // FloatingActionButton(onPressed: );
        ],
      ),
    );
  }
}

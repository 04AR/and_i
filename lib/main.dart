import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:and_i/routes/home.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(title: const Text("T I T L E")),
            drawer: Drawer(
              child: ListView(
                children: const [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
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
            body: const home()));
  }
}

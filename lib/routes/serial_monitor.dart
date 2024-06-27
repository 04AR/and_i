import 'package:and_i/and_i/and_i.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class serial_monitor extends ConsumerWidget {
  serial_monitor({super.key});

  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("S E R I A L   M O N I T O R")),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _scrollDown,
        child: const Icon(Icons.arrow_downward),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("BPS : ${ref.watch(and_i_Port.notifier).buadRate}"),
              ElevatedButton.icon(
                  onPressed: () {
                    ref.read(and_i_Port.notifier).clrSerial();
                  },
                  icon: const Icon(Icons.article_rounded),
                  label: const Text("CLEAR"))
            ]),
          ),
          Text(ref.watch(and_i_Port)),
        ],
      ),
    );
  }
}

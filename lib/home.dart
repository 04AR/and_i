import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:and_i/and_i.dart';
import 'package:and_i/sensors_data.dart';

class home extends ConsumerWidget {
   home({super.key});

  static final usb_data = ChangeNotifierProvider<and_i>((ref) {
    return and_i();
  });

  static final sense = ChangeNotifierProvider<and_i_Sense>((ref) {
    return and_i_Sense();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          Text(ref.watch(usb_data).usb),

          IconButton(onPressed: (){
            ref.read(sense).get_sense();

          }, icon: const Icon(Icons.app_shortcut)),

          Text("x${ref.watch(sense).test_data[0]}"),
          Text("x${ref.watch(sense).test_data[1]}"),
          Text("x${ref.watch(sense).test_data[3]}"),
        ],
      ),
    );
  }
}

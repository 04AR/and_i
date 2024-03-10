import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:and_i/and_i.dart';
import 'package:and_i/sensors_data.dart';

class home extends ConsumerWidget {
   const home({super.key});

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ref.watch(usb_data).usb),

          Text("x${ref.watch(sense).test_data[0]}"),
          Text("y${ref.watch(sense).test_data[1]}"),
          Text("z${ref.watch(sense).test_data[2]}"),
          
          ElevatedButton.icon(onPressed: (){
            ref.read(sense).get_sense();

          }, icon: const Icon(Icons.app_shortcut), 
          label: const Text("get_data")),
        ],
      ),
    );
  }
}

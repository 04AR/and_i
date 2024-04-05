import 'dart:typed_data';

import 'package:flutter/material.dart';
import "package:sensors_plus/sensors_plus.dart";

class and_i_Sense extends ChangeNotifier {
  List<double> test_data = [0, 0, 0];

  Duration sensorInterval = SensorInterval.normalInterval;

  void get_sense() {
    accelerometerEventStream().first.then((value) {
      test_data[0] = value.x;
      test_data[1] = value.y;
      test_data[2] = value.z;
      notifyListeners();
    });
  }

  Future<Float32List> get_acc() async {
    Float32List acc = Float32List(3);

    await accelerometerEventStream().first.then((value) {
      acc[0] = value.x;
      acc[1] = value.y;
      acc[2] = value.z;
    });
    return acc;
  }

  Future<Float32List> get_gyro() async {
    Float32List gyro = Float32List(3);
    await gyroscopeEventStream().first.then((value) {
      gyro[0] = value.x;
      gyro[1] = value.y;
      gyro[2] = value.z;
    });

    return gyro;
  }

  Future<Float32List> get_magno() async{
    Float32List magno = Float32List(3);
    await magnetometerEventStream().first.then((value) {
      magno[0] = value.x;
      magno[1] = value.y;
      magno[2] = value.z;
    });
    return magno;
  }

  Future<Float32List> get_usrAcc() async{
    Float32List usr_acc = Float32List(3);

    await accelerometerEventStream().first.then((value) {
      usr_acc[0] = value.x;
      usr_acc[1] = value.y;
      usr_acc[2] = value.z;
    });

    return usr_acc;
  }
}

import 'package:flutter/material.dart';
import "package:sensors_plus/sensors_plus.dart";

class and_i_Sense extends ChangeNotifier {
  List<double> test_data = [0, 0, 0];

  Duration sensorInterval = SensorInterval.normalInterval;

  List<double> get_usrAcc() {
    List<double> usr_acc = [0, 0, 0];

    userAccelerometerEventStream(samplingPeriod: sensorInterval)
        .map((UserAccelerometerEvent event) {
      usr_acc[0] = event.x;
      usr_acc[1] = event.y;
      usr_acc[2] = event.z;
    }).single;

    return usr_acc;
  }

  void get_sense() async {
    accelerometerEventStream(samplingPeriod: sensorInterval)
        .map((AccelerometerEvent event) {
      test_data[0] = event.x;
      test_data[1] = event.y;
      test_data[2] = event.z;
      notifyListeners();
    }).single;
  }

  List<double> get_acc() {
    List<double> acc = [0, 0, 0];

    accelerometerEventStream(samplingPeriod: sensorInterval)
        .map((AccelerometerEvent event) {
      acc[0] = event.x;
      acc[1] = event.y;
      acc[2] = event.z;
    }).single;
    return acc;
  }

  List<double> get_gyro() {
    List<double> gyro = [0, 0, 0];
    gyroscopeEventStream(samplingPeriod: sensorInterval)
        .map((GyroscopeEvent event) {
      gyro[0] = event.x;
      gyro[1] = event.y;
      gyro[2] = event.z;
    }).single;

    return gyro;
  }

  List<double> get_magno() {
    List<double> magno = [0, 0, 0];
    magnetometerEventStream(samplingPeriod: sensorInterval)
        .map((MagnetometerEvent event) {
      magno[0] = event.x;
      magno[1] = event.x;
      magno[2] = event.x;
    }).single;
    return magno;
  }
}

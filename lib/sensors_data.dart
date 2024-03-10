import 'package:flutter/material.dart';
import "package:sensors_plus/sensors_plus.dart";

class and_i_Sense extends ChangeNotifier{

   List<double> test_data = [0, 0, 0];

  Duration sensorInterval = SensorInterval.normalInterval;

  void get_usrAcc() {
    userAccelerometerEventStream(samplingPeriod: sensorInterval)
        .listen((UserAccelerometerEvent event) {
      print(event);
    });
  }

  void get_sense() {
    accelerometerEventStream(samplingPeriod: sensorInterval)
        .map((AccelerometerEvent event) {
      test_data[0] = event.x;
      test_data[1] = event.y;
      test_data[2] = event.z;
    });
    notifyListeners();
  }

  List<double> get_acc() {
    List<double> usr_acc = [0, 0, 0];

    accelerometerEventStream(samplingPeriod: sensorInterval)
        .map((AccelerometerEvent event) {
      usr_acc[0] = event.x;
      usr_acc[1] = event.y;
      usr_acc[2] = event.z;
    }).single;
    return usr_acc;
  }

  void get_gyro() {
    gyroscopeEventStream(samplingPeriod: sensorInterval).listen(
      (GyroscopeEvent event) {
        print(event);
      },
      onError: (error) {
        print("device does not support it");
      },
      cancelOnError: true,
    );
  }

  void get_magno() {
    magnetometerEventStream(samplingPeriod: sensorInterval).listen(
      (MagnetometerEvent event) {
        print(event);
      },
      onError: (error) {
        print("device does not support it");
      },
      cancelOnError: true,
    );
  }
}

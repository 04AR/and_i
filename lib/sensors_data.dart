import 'dart:async';

import 'package:flutter/material.dart';
import "package:sensors_plus/sensors_plus.dart";
import 'package:location/location.dart';

class and_i_Sense extends ChangeNotifier{
  UserAccelerometerEvent? _userAccelerometerEvent;
  AccelerometerEvent? _accelerometerEvent;
  GyroscopeEvent? _gyroscopeEvent;
  MagnetometerEvent? _magnetometerEvent;

  int? _userAccelerometerLastInterval;
  int? _accelerometerLastInterval;
  int? _gyroscopeLastInterval;
  int? _magnetometerLastInterval;

  Duration sensorInterval = SensorInterval.normalInterval;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  void get_usrAcc() {
    userAccelerometerEventStream(samplingPeriod: sensorInterval)
        .listen((UserAccelerometerEvent event) {
      print(event);
    });
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

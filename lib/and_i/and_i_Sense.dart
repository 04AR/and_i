import 'dart:typed_data';
// import "package:sensors_plus/sensors_plus.dart";
import 'package:motion_sensors/motion_sensors.dart';

class and_i_Sense {
  MotionSensors sensor = MotionSensors();

  Float32List acc = Float32List(3);
  Float32List usr_acc = Float32List(3);
  Float32List gyro = Float32List(3);
  Float32List magno = Float32List(3);
  Float32List orient = Float32List(3);

  and_i_Sense() {
    sensor.accelerometer.listen((value) {
      acc[0] = value.x;
      acc[1] = value.y;
      acc[2] = value.z;
    });

    sensor.userAccelerometer.listen((value) {
      usr_acc[0] = value.x;
      usr_acc[1] = value.y;
      usr_acc[2] = value.z;
    });

    sensor.accelerometer.listen((value) {
      gyro[0] = value.x;
      gyro[1] = value.y;
      gyro[2] = value.z;
    });

    sensor.orientation.listen((value) {
      orient[0] = value.pitch;
      orient[1] = value.roll;
      orient[2] = value.yaw;
    });

    sensor.magnetometer.listen((value) {
      magno[0] = value.x;
      magno[1] = value.y;
      magno[2] = value.z;
    });
  }

  Future<Float32List> get_acc() async {
    return acc;
  }

  Future<Float32List> get_gyro() async {
    return gyro;
  }

  Future<Float32List> get_magno() async {
    return magno;
  }

  Future<Float32List> get_usrAcc() async {
    return usr_acc;
  }

  Future<Float32List> get_orient() async {
    return orient;
  }
}

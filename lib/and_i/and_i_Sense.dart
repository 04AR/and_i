import 'dart:typed_data';
// import "package:sensors_plus/sensors_plus.dart";
import 'package:motion_sensors/motion_sensors.dart';

class and_i_Sense {
  MotionSensors sensor = MotionSensors();

  Future<Float32List> get_acc() async {
    Float32List acc = Float32List(3);

    await sensor.accelerometer.first.then((value) {
      acc[0] = value.x;
      acc[1] = value.y;
      acc[2] = value.z;
    });
    return acc;
  }

  Future<Float32List> get_gyro() async {
    Float32List gyro = Float32List(3);

    await sensor.gyroscope.first.then((value) {
      gyro[0] = value.x;
      gyro[1] = value.y;
      gyro[2] = value.z;
    });
    return gyro;
  }

  Future<Float32List> get_magno() async {
    Float32List magno = Float32List(3);
  
    await sensor.magnetometer.first.then((value) {
      magno[0] = value.x;
      magno[1] = value.y;
      magno[2] = value.z;
    });

    return magno;
  }

  Future<Float32List> get_usrAcc() async {
    Float32List usr_acc = Float32List(3);

    await sensor.userAccelerometer.first.then((value) {
      usr_acc[0] = value.x;
      usr_acc[1] = value.y;
      usr_acc[2] = value.z;
    });
    return usr_acc;
  }


  Future<Float32List> get_orient() async {
    Float32List orient = Float32List(3);
    
    await sensor.orientation.first.then((value) {

    orient[0] = value.pitch;
    orient[1] = value.roll;
    orient[2] = value.yaw;

    });
    return orient;
  }
}

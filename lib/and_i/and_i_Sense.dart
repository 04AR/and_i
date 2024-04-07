import 'dart:typed_data';
import "package:sensors_plus/sensors_plus.dart";

class and_i_Sense {
  Duration sensorInterval = SensorInterval.normalInterval;

  Future<Float32List> get_acc() async {
    Float32List acc = Float32List(3);
    await accelerometerEventStream().first.then((value) {
      acc[0] = value.x;
      acc[1] = value.y;
      acc[2] = value.z;
    }).onError((error, stackTrace) {
      acc[0] = 1.1;
      acc[1] = 1.1;
      acc[2] = 1.1;
    }).timeout(const Duration(seconds: 1), onTimeout: (){
      acc[0] = 9.8;
      acc[1] = 9.8;
      acc[2] = 9.8;
    });
    return acc;
  }

  Future<Float32List> get_gyro() async {
    Float32List gyro = Float32List(3);
    await gyroscopeEventStream().first.then((value) {
      gyro[0] = value.x;
      gyro[1] = value.y;
      gyro[2] = value.z;
    }).onError((error, stackTrace) {
      gyro[0] = 1.1;
      gyro[1] = 1.1;
      gyro[2] = 1.1;
    }).timeout(const Duration(seconds: 1), onTimeout: (){
      gyro[0] = 9.8;
      gyro[1] = 9.8;
      gyro[2] = 9.8;
    });

    return gyro;
  }

  Future<Float32List> get_magno() async{
    Float32List magno = Float32List(3);
    await magnetometerEventStream().first.then((value) {
      magno[0] = value.x;
      magno[1] = value.y;
      magno[2] = value.z;
    }).onError((error, stackTrace) {
      magno[0] = 1.1;
      magno[1] = 1.1;
      magno[2] = 1.1;
    }).timeout(const Duration(seconds: 1), onTimeout: (){
      magno[0] = 9.8;
      magno[1] = 9.8;
      magno[2] = 9.8;
    });
    return magno;
  }

  Future<Float32List> get_usrAcc() async{
    Float32List usr_acc = Float32List(3);
    await accelerometerEventStream().first.then((value) {
      usr_acc[0] = value.x;
      usr_acc[1] = value.y;
      usr_acc[2] = value.z;
    }).onError((error, stackTrace) {
      usr_acc[0] = 1.1;
      usr_acc[1] = 1.1;
      usr_acc[2] = 1.1;
    }).timeout(const Duration(seconds: 1), onTimeout: (){
      usr_acc[0] = 9.8;
      usr_acc[1] = 9.8;
      usr_acc[2] = 9.8;
    });

    return usr_acc;
  }
}

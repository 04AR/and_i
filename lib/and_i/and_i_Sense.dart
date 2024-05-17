import 'dart:typed_data';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:environment_sensors/environment_sensors.dart';

class and_i_Sense {
  final MotionSensors sensor = MotionSensors();
  final EnvironmentSensors environmentSensors = EnvironmentSensors();

  Float32List acc = Float32List(3);
  Float32List usrAcc = Float32List(3);
  Float32List gyro = Float32List(3);
  Float32List magno = Float32List(3);
  Float32List orient = Float32List(3);

  Float32List light = Float32List(1);
  Float32List humidity = Float32List(1);
  Float32List pressure = Float32List(1);

  and_i_Sense() {

    sensor.accelerometer.listen((event) {
      acc[0] = event.x;
      acc[1] = event.y;
      acc[2] = event.z;
    }).onError((error){
      acc.addAll([0,0,0]);
    });

    sensor.userAccelerometer.listen((event) {
      usrAcc[0] = event.x;
      usrAcc[1] = event.y;
      usrAcc[2] = event.z;
    }).onError((error){
      usrAcc.addAll([0,0,0]);
    });

    sensor.accelerometer.listen((event) {
      gyro[0] = event.x;
      gyro[1] = event.y;
      gyro[2] = event.z;
    }).onError((error){
      gyro.addAll([0,0,0]);
    });

    sensor.orientation.listen((event) {
      orient[0] = event.pitch;
      orient[1] = event.roll;
      orient[2] = event.yaw;
    }).onError((error){
      orient.addAll([0,0,0]);
    });

    sensor.magnetometer.listen((event) {
      magno[0] = event.x;
      magno[1] = event.y;
      magno[2] = event.z;
    }).onError((error){
      magno.addAll([0,0,0]);
    });

    environmentSensors.light.listen((event) {
      light[0] = event;
    }).onError((error) {
      light[0] = 0;
    });

    environmentSensors.pressure.listen((event) {
      pressure[0] = event;
    }).onError((error) {
      pressure[0] = 0;
    });

    environmentSensors.humidity.listen((event) {
      humidity[0] = event;
    }).onError((error) {
      humidity[0] = 0;
    });
  }

  Float32List get_acc()  {
    return acc;
  }

  Float32List get_gyro(){
    return gyro;
  }

  Float32List get_magno()  {
    return magno;
  }

  Float32List get_usrAcc()  {
    return usrAcc;
  }

  Float32List get_orient()  {
    return orient;
  }

  Float32List get_light()  {
    return light;
  }

  Float32List get_humd()  {
    return humidity;
  }

  Float32List get_pres()  {
    return pressure;
  }

  Future<Position> curr_loc() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

  
}

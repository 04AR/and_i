import 'dart:async';
import 'dart:typed_data';

import 'package:torch_light/torch_light.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:environment_sensors/environment_sensors.dart';
import 'package:geolocator/geolocator.dart';

class and_i_Sense {
  final MotionSensors sensor = MotionSensors();
  final EnvironmentSensors environmentSensors = EnvironmentSensors();

  Float32List acc = Float32List(3);
  Float32List gyro = Float32List(3);
  Float32List magno = Float32List(3);
  Float32List orient = Float32List(3);
  Float32List usrAcc = Float32List(3);
  Float32List absOrient = Float32List(3);

  Float32List light = Float32List(1);
  Float32List humidity = Float32List(1);
  Float32List pressure = Float32List(1);

  and_i_Sense() {
    sensor.accelerometer.distinct().listen((event) {
      acc[0] = event.x;
      acc[1] = event.y;
      acc[2] = event.z;
    }).onError((error) {
      acc.addAll([0, 0, 0]);
    });

    sensor.userAccelerometer.distinct().listen((event) {
      usrAcc[0] = event.x;
      usrAcc[1] = event.y;
      usrAcc[2] = event.z;
    }).onError((error) {
      usrAcc.addAll([0, 0, 0]);
    });

    sensor.accelerometer.distinct().listen((event) {
      gyro[0] = event.x;
      gyro[1] = event.y;
      gyro[2] = event.z;
    }).onError((error) {
      gyro.addAll([0, 0, 0]);
    });

    sensor.orientation.distinct().listen((event) {
      orient[0] = event.pitch;
      orient[1] = event.roll;
      orient[2] = event.yaw;
    }).onError((error) {
      orient.addAll([0, 0, 0]);
    });

    sensor.absoluteOrientation.distinct().listen((event) {
      absOrient[0] = event.pitch;
      absOrient[1] = event.roll;
      absOrient[2] = event.yaw;
    }).onError((error) {
      absOrient.addAll([0, 0, 0]);
    });

    sensor.magnetometer.distinct().listen((event) {
      magno[0] = event.x;
      magno[1] = event.y;
      magno[2] = event.z;
    }).onError((error) {
      magno.addAll([0, 0, 0]);
    });

    environmentSensors.light.distinct().listen((event) {
      light[0] = event;
    }).onError((error) {
      light[0] = 0;
    });

    environmentSensors.pressure.distinct().listen((event) {
      pressure[0] = event;
    }).onError((error) {
      pressure[0] = 0;
    });

    environmentSensors.humidity.distinct().listen((event) {
      humidity[0] = event;
    }).onError((error) {
      humidity[0] = 0;
    });
  }

  Float32List getAcc() {
    return acc;
  }

  Float32List getGyro() {
    return gyro;
  }

  Float32List getMagno() {
    return magno;
  }

  Float32List getUsrAcc() {
    return usrAcc;
  }

  Float32List getOrient() {
    return orient;
  }

  Float32List getAbsOrient() {
    return absOrient;
  }

  Float32List getLumen() {
    return light;
  }

  Float32List getHumid() {
    return humidity;
  }

  Float32List getPressure() {
    return pressure;
  }

  void flash() async {
    try {
      final isTorchAvailable = await TorchLight.isTorchAvailable();
      try {
        await TorchLight.enableTorch();
        // Enable torch and manage all kind of errors
      } on EnableTorchExistentUserException catch (e) {
        // The camera is in use
      } on EnableTorchNotAvailableException catch (e) {
        // Torch was not detected
      } on EnableTorchException catch (e) {
        // Torch could not be enabled due to another error
      }

      // Disable torch and manage all kind of errors
      try {
        await TorchLight.disableTorch();
      } on DisableTorchExistentUserException catch (e) {
        // The camera is in use
      } on DisableTorchNotAvailableException catch (e) {
        // Torch was not detected
      } on DisableTorchException catch (e) {
        // Torch could not be disabled due to another error
      }
    } on Exception catch (e) {
      // Handle error
    }
  }

  Future<Position> currLoc() async {
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

import 'dart:async';
import 'dart:typed_data';

import 'package:and_i/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:torch_light/torch_light.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:environment_sensors/environment_sensors.dart';
import 'package:geolocator/geolocator.dart';

final sensorsProvider = ChangeNotifierProvider<and_i_Sense>((ref) {
  return and_i_Sense();
});

class and_i_Sense extends ChangeNotifier {

  final MotionSensors sensor = MotionSensors();
  final EnvironmentSensors environmentSensors = EnvironmentSensors();

  late final StreamSubscription? _accStream;
  late final StreamSubscription? _usrAccStream;
  late final StreamSubscription? _gyroStream;
  late final StreamSubscription? _magnoStream;
  late final StreamSubscription? _orientStream;
  // late final Stream<AbsoluteOrientationEvent> _absOrientStream;
  late final StreamSubscription _lumenStream, _pressurStream, _humidityStream;

  bool isloc = false;

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
    List<Function> func = [
      initAccel,
      initGyro,
      initMagno,
      initOrient,
      initEnv,
      initLoc,
      initCam
    ];
    List<bool> flags = (prefs.getStringList("senseKey") ??
            <bool>[false, false, false, false, false, false, false])
        .map((val) => val == 'true')
        .toList();

    for (int i = 0; i < func.length; i++) {
      if (flags[i]) {
        func[i].call();
      }
    }

    locPermission();
  }

  void initAccel() {
    sensor.accelerometerUpdateInterval = Duration.microsecondsPerSecond ~/ 60;
    sensor.userAccelerometerUpdateInterval =
        Duration.microsecondsPerSecond ~/ 60;
    // Initialzing Accelerometer (return 0 if no sensor found)
    _accStream = sensor.accelerometer.distinct().listen((event) {
      acc[0] = event.x;
      acc[1] = event.y;
      acc[2] = event.z;
    });

    SnackBarService.showSnackBar(content: "Accel Init");

    //  Initialzing User_Accelerometer (return 0 if no sensor found)
    _usrAccStream = sensor.userAccelerometer.distinct().listen((event) {
      usrAcc[0] = event.x;
      usrAcc[1] = event.y;
      usrAcc[2] = event.z;
    });
  }

  void initGyro() {
    // _gyroStream = sensor.gyroscope;
    sensor.gyroscopeUpdateInterval = Duration.microsecondsPerSecond ~/ 60;
    // // Initialzing Gyroscope (return 0 if no sensor found)
    _gyroStream = sensor.gyroscope.distinct().listen((event) {
      gyro[0] = event.x;
      gyro[1] = event.y;
      gyro[2] = event.z;
    });
  }

  void initMagno() {
    // // Initialzing Magnometer (return 0 if no sensor found)
    _magnoStream = sensor.magnetometer.distinct().listen((event) {
      magno[0] = event.x;
      magno[1] = event.y;
      magno[2] = event.z;
    });
  }

  void initOrient() {
    // _absOrientStream = sensor.absoluteOrientation;
    sensor.orientationUpdateInterval = Duration.microsecondsPerSecond ~/ 60;
    SnackBarService.showSnackBar(content: "orient Init");
    // sensor.absoluteOrientationUpdateInterval = Duration.microsecondsPerSecond ~/60;
    // // Initialzing Orientation (return 0 if no sensor found)
    _orientStream = sensor.orientation.distinct().listen((event) {
      orient[0] = event.pitch;
      orient[1] = event.roll;
      orient[2] = event.yaw;
    });

    // // Initialzing Absolute_Orientation (return 0 if no sensor found)
    // _absOrientStream.distinct().listen((event) {
    //   absOrient[0] = event.pitch;
    //   absOrient[1] = event.roll;
    //   absOrient[2] = event.yaw;
    // }).onError((error) {
    //   absOrient.addAll([0, 0, 0]);
    // });
  }

  void initEnv() {
    // // Initialzing Light_Sensor
    environmentSensors.light.distinct().listen((event) {
      light[0] = event;
    }).onError((error) {
      light[0] = 0;
    });

    // // Initialzing Pressure_Sensor (return 0 if no sensor found)
    environmentSensors.pressure.distinct().listen((event) {
      pressure[0] = event;
    }).onError((error) {
      pressure[0] = 0;
    });

    // // Initialzing Humidity_Sensor (return 0 if no sensor found)
    environmentSensors.humidity.distinct().listen((event) {
      humidity[0] = event;
    }).onError((error) {
      humidity[0] = 0;
    });
  }

  void initLoc() {}

  void initCam() {}

  void disposeAccel() {
    acc = Float32List(3);
    SnackBarService.showSnackBar(content: "Accel dispose");
    _accStream!.cancel();
    _usrAccStream!.cancel();
  }

  void disposeGyro() {
    gyro = Float32List(3);
    _gyroStream!.cancel();
  }

  void disposeMagno() {
    magno = Float32List(3);
    _magnoStream!.cancel();
  }

  void disposeOrient() {
    orient = Float32List(3);
    SnackBarService.showSnackBar(content: "Orient dispose");
    _orientStream!.cancel();
  }

  void disposeEnv() {
    light = Float32List(3);
    pressure = Float32List(3);
    humidity = Float32List(3);
    _lumenStream!.cancel();
    _pressurStream!.cancel();
    _humidityStream!.cancel();
  }

  void flashOn() async {
    try {
      await TorchLight.enableTorch();
      // Enable torch and manage all kind of errors
    } on EnableTorchExistentUserException catch (e) {
      SnackBarService.showSnackBar(content: e.toString());
      // The camera is in use
    } on EnableTorchNotAvailableException catch (e) {
      SnackBarService.showSnackBar(content: e.toString());
      // Torch was not detected
    } on EnableTorchException catch (e) {
      SnackBarService.showSnackBar(content: e.toString());
      // Torch could not be enabled due to another error
    }
  }

  void flashOff() async {
    try {
      await TorchLight.disableTorch();
    } on DisableTorchExistentUserException catch (e) {
      SnackBarService.showSnackBar(content: e.toString());
      // The camera is in use
    } on DisableTorchNotAvailableException catch (e) {
      SnackBarService.showSnackBar(content: e.toString());
      // Torch was not detected
    } on DisableTorchException catch (e) {
      SnackBarService.showSnackBar(content: e.toString());
      // Torch could not be disabled due to another error
    }
  }

  void locPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        isloc = false;
        SnackBarService.showSnackBar(
            content: 'Location permissions are denied.');
        // Future.error('Location permissions are denied');
        return;
      } else {
        isloc = true;
      }
    } else {
      isloc = true;
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      SnackBarService.showSnackBar(
          content:
              'Location permissions are permanently denied, we cannot request permissions.');
      //  Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
  }

  Future<Float32List> currLoc() async {
    Float32List currPos = Float32List(9);
    // Position currPos = Position(
    //     longitude: 0,
    //     latitude: 0,
    //     timestamp: DateTime.now(),
    //     accuracy: 0,
    //     altitude: 0,
    //     altitudeAccuracy: 0,
    //     heading: 0,
    //     headingAccuracy: 0,
    //     speed: 0,
    //     speedAccuracy: 0);
    if (isloc) {
      bool serviceEnabled;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        SnackBarService.showSnackBar(
            content: 'Location services are disabled.');
        // Future.error('Location services are disabled.');
        return currPos;
      }

      await Geolocator.getCurrentPosition().then((value) {
        currPos[0] = value.latitude;
        currPos[1] = value.longitude;
        currPos[2] = value.accuracy;
        currPos[3] = value.altitude;
        currPos[4] = value.altitudeAccuracy;
        currPos[5] = value.heading;
        currPos[6] = value.headingAccuracy;
        currPos[7] = value.speed;
        currPos[8] = value.speedAccuracy;

        // currPos.addAll([value.latitude, value.longitude, value.altitude]);
      });
      return currPos;
    } else {
      return currPos;
    }
  }
}

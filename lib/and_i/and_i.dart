// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'dart:typed_data';
import 'package:and_i/main.dart';
// import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:and_i/and_i/and_i_Sense.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final and_i_Port = NotifierProvider<and_i, String>(() {
  return and_i();
});

class and_i extends Notifier<String> {
  int buadRate = 115200;
  UsbPort? _port;

  String usb = "No device connected";

  // sensor codes
  static const int ACCELEROMETER = 0x80;
  static const int GYROSCOPE = 0x81;
  static const int MAGNOMETER = 0x82;
  static const int USR_ACCELEROMETER = 0x83;
  static const int ORIENT = 0x84;
  static const int ABS_ORIENT = 0x85;
  static const int LUMEN = 0x86;
  static const int PRESSURE = 0x87;
  static const int HUMIDITY = 0x88;
  // static const int TEMP = 0x89;
  static const int COORDS = 0x8A;
  static const int FLASHLIGHT = 0x8B;
  // static const int MIC = 0x8C;
  // static const int SPEECH_REG = 0x8E;

  and_i() {
    // Listening the USB_ATTACHED event
    UsbSerial.usbEventStream!.listen((UsbEvent e) {
      if (e.event == UsbEvent.ACTION_USB_ATTACHED) {
        getPort(e, buadRate);
        usb = e.device!.deviceName;
        SnackBarService.showSnackBar(content: "Connected");
        state += "";
      }
      if (e.event == UsbEvent.ACTION_USB_DETACHED) {
        _port!.close();
        usb = "No device connected";
        SnackBarService.showSnackBar(content: "Disconnected");
        state += "\n";
      }
    });
  }

  @override
  String build() {
    return "";
  }

  // Clearing Serial_Monitor
  void clrSerial() {
    state = "";
    // notifyListeners();
  }

  void getPort(UsbEvent event, int bps) async {
    _port = await event.device!.create();
    if (await (_port!.open()) != true) {
      return;
    }
    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        bps, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    // Initializing and_i on micro-controller by sending code
    writeSerial(Uint8List.fromList([0x40]));

    readSerial();
  }

  void readSerial() {
    _port?.inputStream?.listen((event) {
      // get the first serial character code
      int cmd = event.first;

      final sense = ref.watch(sensorsProvider);

      // 0x80 last ASCII character code
      if (cmd < 0x80) {
        state += utf8.decode(event);
      } else {
        switch (cmd) {
          case ACCELEROMETER:
            writeSerial(Uint8List.view(sense.acc.buffer));
            break;
          case GYROSCOPE:
            writeSerial(Uint8List.view(sense.gyro.buffer));
            break;
          case MAGNOMETER:
            writeSerial(Uint8List.view(sense.magno.buffer));
            break;
          case USR_ACCELEROMETER:
            writeSerial(Uint8List.view(sense.usrAcc.buffer));
            break;
          case ORIENT:
            writeSerial(Uint8List.view(sense.orient.buffer));
            break;
          case ABS_ORIENT:
            writeSerial(Uint8List.view(sense.absOrient.buffer));
            break;
          case LUMEN:
            writeSerial(Uint8List.view(sense.light.buffer));
            break;
          case HUMIDITY:
            writeSerial(Uint8List.view(sense.humidity.buffer));
            break;
          case PRESSURE:
            writeSerial(Uint8List.view(sense.pressure.buffer));
            break;
          case COORDS:
            ref.read(sensorsProvider.notifier).currLoc().then((value){
              state += value.toString();
              // notifyListeners();
              writeSerial(Uint8List.view(value.buffer));
            });
            break;
          case FLASHLIGHT:
            if (event.last == 0) {
              ref.read(sensorsProvider.notifier).flashOff();
            } else {
              ref.read(sensorsProvider.notifier).flashOn();
            }
            break;
          default:
            state += "$event";
        }
      }
    });
  }

  Future<void> writeSerial(Uint8List data) async {
    _port!.write(data);
  }
}

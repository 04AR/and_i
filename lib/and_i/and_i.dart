// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:and_i/and_i/and_i_Sense.dart';

class and_i extends ChangeNotifier {
  int buadRate = 115200;
  UsbPort? _port;

  and_i_Sense sensors = and_i_Sense();

  String serialData = "";

  String usb = "No device connected";


  // sensor codes
  static const int ACCELEROMETER = 0x80;
  static const int GYROSCOPE = 0x81;
  static const int MAGNOMETER = 0x82;
  static const int USR_ACCELEROMETER = 0x83;
  static const int USR_GYROSCOPE = 0x84;
  static const int ORIENT = 0x85;
  static const int USR_ORIENT = 0x86;
  static const int LUMEN = 0x87;
  static const int PRESSURE = 0x88;
  static const int HUMIDITY = 0x89;
  static const int TEMP = 0x90;
  static const int COORDS = 0x91;
  static const int LATITUDE = 0x92;
  static const int LONGITUDE = 0x93;
  static const int ALTITUDE = 0x94;

  and_i() {
    UsbSerial.usbEventStream!.listen((UsbEvent e) {
      if (e.event == UsbEvent.ACTION_USB_ATTACHED) {
        getPort(e, buadRate);
        usb = e.device!.deviceName;
        notifyListeners();
      }
      if (e.event == UsbEvent.ACTION_USB_DETACHED) {
        _port!.close();
        usb = "No device connected";
        notifyListeners();
      }
    });
  }

  void clrSerial() {
    serialData = "";
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

    writeSerial(Uint8List.fromList([0x40]));

    readSerial();
  }

  void readSerial() {
    _port?.inputStream?.listen((event) async {
      int cmd = event.first;

      if (cmd < 0x80) {
        serialData += utf8.decode(event);
      } else {
        switch (cmd) {
          case ACCELEROMETER:
            writeSerial(Uint8List.view(sensors.get_acc().buffer));
            break;
          case GYROSCOPE:
            writeSerial(Uint8List.view(sensors.get_gyro().buffer));
            break;
          case MAGNOMETER:
            writeSerial(Uint8List.view(sensors.get_magno().buffer));
            break;
          case ORIENT:
            writeSerial(Uint8List.view(sensors.get_orient().buffer));
            break;
          case USR_ACCELEROMETER:
            writeSerial(Uint8List.view(sensors.get_usrAcc().buffer));
            break;
          case LUMEN:
            writeSerial(Uint8List.view(sensors.get_light().buffer));
            break;
          case HUMIDITY:
            writeSerial(Uint8List.view(sensors.get_humd().buffer));
            break;
          case PRESSURE:
            writeSerial(Uint8List.view(sensors.get_pres().buffer));
            break;
          case COORDS:
            await sensors.curr_loc().then((value) {
              Float32List pos = Float32List(3);
              pos.addAll([value.latitude, value.longitude, value.altitude]);
              writeSerial(Uint8List.view(pos.buffer));
            });
            break;
          default:
            serialData += "$event";
        }
      }
      notifyListeners();
    });
  }

  Future<bool> writeSerial(Uint8List data) async {
    _port!.write(data);
    return true;
  }
}

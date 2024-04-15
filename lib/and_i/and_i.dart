import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:and_i/and_i/and_i_Sense.dart';

class and_i extends ChangeNotifier {
  int buad_rate = 115200;
  UsbPort? _port;

  and_i_Sense sensors = and_i_Sense();

  String serial_data = "";

  String usb = "No device connected";

  and_i() {
    UsbSerial.usbEventStream!.listen((UsbEvent e) {
      if (e.event == UsbEvent.ACTION_USB_ATTACHED) {
        get_port(e, buad_rate);
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

  void Clr_Serial(){
    serial_data = "";
  }

  void get_port(UsbEvent event, int bps) async {
    _port = await event.device!.create();
    if (await (_port!.open()) != true) {
      return;
    }
    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        bps, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    write_serial(Uint8List.fromList([0x40]));

    read_serial();
  }

  void read_serial() {
    _port?.inputStream?.listen((event) async {
      int cmd = event.first;

      if (cmd < 0x80) {
        serial_data += utf8.decode(event);
      } else {
        switch (cmd) {
          case 0x80:
            await sensors.get_acc().then((value) {
              write_serial(Uint8List.view(value.buffer));
            });
            break;
          case 0x81:
            await sensors.get_gyro().then((value) {
              write_serial(Uint8List.view(value.buffer));
            });
            break;
          case 0x82:
            await sensors.get_magno().then((value) {
              write_serial(Uint8List.view(value.buffer));
            });
            break;
          case 0x83:
            await sensors.get_orient().then((value) {
              write_serial(Uint8List.view(value.buffer));
            });
            break;
          default:
            serial_data += "$event";
        }
      }
      notifyListeners();
    });
  }

  Future<bool> write_serial(Uint8List data) async {
    await _port!.write(data);
    return true;
  }
}

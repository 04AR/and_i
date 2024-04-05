import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:and_i/and_i/and_i_Sense.dart';

class and_i extends ChangeNotifier {
  
  int buad_rate = 115200;
  UsbPort? _port;

  and_i_Sense sensors =  and_i_Sense();

  String serial_cmd = "***";

  String cmd = "*****";
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

  void get_port(UsbEvent event, int bps) async {
    _port = await event.device!.create();
    if (await (_port!.open()) != true) {
      return;
    }
    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        bps, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    read_serial();
  }

  void read_serial() {
    _port?.inputStream?.listen((event) {
      int cmd = event.first;
      switch (cmd) {
        case 0x64:
          serial_cmd += "A";
          break;
        case 0x80:
          write_serial(Uint8List.fromList(sensors.get_acc().toString().codeUnits));
          break;
        default:
          serial_cmd += utf8.decode(event);
      }
      notifyListeners();
    });
  }

  Future<bool> write_serial(Uint8List data) async {
    await _port!.write(data);
    return true;
  }
}

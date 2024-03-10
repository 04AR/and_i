import 'dart:typed_data';
// import 'package:usb_serial/transaction.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';


class and_i extends ChangeNotifier{

  // Map<int, String> commands = {0x1 : "acc",
  //                              0x2 : "gyr",
  //                              0x3 : "mag",
  //                              0x4 : "ori",
  //                              0x5 : "lum",
  //                              0x6 : "clk",
  //                              0x7 : "btr",
  //                              0x8 : "prx",
  //                              0x9 : "geo",
  //                              0xa : "ir",
  //                              0xb : "pre",
  //                              0xc : "alt",
  //                              0xd : "tch",
  //                              0xe : "comp",
  //                              0xf : "cam",
  //                              0x10 : "rfid",
  //                              0x11 : "rel_acc",
  //                              0x12 : "rel_gyr",
  //                              0x13 : "rel_mag",
  //                              0x14 : "rel_ori",
  //                              0x15 : "pic",
  //                              0x16 : "fg_id",
  //                              0x17 : "fc_id",
  //                              0x18 : "",
  //                              0x19 : "",
  //                              0x1a : "",
  //                              0x1b : "",
  //                              0x1c : "",
  //                              0x1d : "",
  //                              };

  String usb = "No device connected";
  UsbPort? _port;

  and_i() {
    UsbSerial.usbEventStream!.listen((UsbEvent e) {
      if (e.event == UsbEvent.ACTION_USB_ATTACHED) {
        get_port(e);
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

  void get_port(UsbEvent event) async {
    _port = await event.device!.create();
    if (await (_port!.open()) != true) {
      return;
    }
    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_EVEN);
  }

  bool read_serial() {
    _port!.inputStream!.listen((event) {
      print(event);
    });
    return true;
  }

  Future<bool> write_serial(Uint8List data) async {
    await _port!.write(data);
    return true;
  }

}



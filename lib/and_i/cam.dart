import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class cam extends StatefulWidget {
  const cam({super.key});

  @override
  State<cam> createState() => _camState();
}

class _camState extends State<cam> {

  late List<CameraDescription> _cameras;
  late CameraController controller;

  @override
  void initState() async{
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose(); 
    super.dispose();
  }

  void takeImg(){
    controller.takePicture();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController? cameraController = controller;

  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }

  //   if (state == AppLifecycleState.inactive) {
  //     cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     _initializeCameraController(cameraController.description);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized ? CameraPreview(controller) : Container();
  }
}
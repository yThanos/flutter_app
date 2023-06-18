import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class cameraTest extends StatefulWidget {
  const cameraTest({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  State<cameraTest> createState() => _cameraTestState();
}

class _cameraTestState extends State<cameraTest> {

  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_cameraController);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          FloatingActionButton(
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Attempt to take a picture and then get the location
                // where the image file is saved.
                final image = await _cameraController.takePicture();
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: const Icon(Icons.camera_alt),
          )
        ],
      ) ,
    );
  }
}

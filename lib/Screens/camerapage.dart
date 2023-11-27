import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _takePicture();
  }

  Future<void> _takePicture() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
        // If you want to do something with the image file, you can use the 'pickedFile'
        print('Image Path: ${pickedFile.path}');
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
              File(_imageFile!.path),
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            )
                : const Text('No image selected'),
          ],
        ),
      ),
    );
  }
}

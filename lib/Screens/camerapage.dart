import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
        _saveImage(pickedFile.path);

        setState(() {
          _imageFile = pickedFile;
        });

        print('Image Path: ${pickedFile.path}');
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _saveImage(String imagePath) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String appDirPath = appDir.path;

      final String fileName = 'imagetake .png'; // You can customize the file name
      final String filePath = '$appDirPath/$fileName';

      // Copy the file to the app's document directory
      await File(imagePath).copy(filePath);

      print('Image saved to: $filePath');
    } catch (e) {
      print('Error saving image: $e');
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

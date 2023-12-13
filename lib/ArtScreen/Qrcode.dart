import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallpaper/ArtScreen/arcore.dart'; // Import your existing ArCoreApp widget

class QRCodeScanner extends StatefulWidget {
  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrResult = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrResult = scanData.code ?? ''; // Use the null-aware operator to handle null
        loadModel(qrResult); // Call the loadModel method with the scanned modelPath
      });
    });
  }


  void loadModel(String? modelPath) {
    if (modelPath != null && modelPath.isNotEmpty) {
      // Navigate to the AR screen with the specified modelPath
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArCoreApp(modelPath: modelPath),
        ),
      );
    } else {
      // Handle the case when qrResult is null or empty
      print('Invalid QR code result');
      // You might want to display an error message or handle it in some way
    }
  }


  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }
}

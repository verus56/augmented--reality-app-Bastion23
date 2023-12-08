import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class PrimaryLowerLeftCanine extends StatefulWidget {
  PrimaryLowerLeftCanine({Key? key}) : super(key: key);

  @override
  _PrimaryLowerLeftCanineState createState() => _PrimaryLowerLeftCanineState();
}

class _PrimaryLowerLeftCanineState extends State<PrimaryLowerLeftCanine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primary Lower Left Canine (FDI 73)'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add a 3D model here if available. Replace 'model_url_here' with the actual model URL.
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ModelViewer(
                src: 'assets/medical/Dentist/primary_lower_left_canine_fdi_73.glb', // Add your 3D model URL
                ar: true,
                alt: 'A 3D model of Primary Lower Left Canine',
                autoPlay: true,
                autoRotate: true,
                cameraControls: true,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Primary Lower Left Canine (FDI 73)',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Description of the primary lower left canine (FDI 73) and its role in the primary dentition.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Anatomy and Function',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• Primary tooth: The primary lower left canine is one of the primary teeth in the lower jaw, typically known as the "baby tooth."\n'
                            '• Function: Primary canines play a crucial role in biting and tearing food during early childhood.\n'
                            '• Importance: Understanding primary dentition is essential for pediatric dentistry and monitoring dental development.\n',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

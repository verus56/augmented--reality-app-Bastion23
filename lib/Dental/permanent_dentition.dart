import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class PermanentDentition extends StatefulWidget {
  PermanentDentition({Key? key}) : super(key: key);

  @override
  _PermanentDentitionState createState() => _PermanentDentitionState();
}

class _PermanentDentitionState extends State<PermanentDentition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permanent Dentition'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ModelViewer(
                src: 'assets/medical/Dentist/permanent_dentition.glb',
                ar: true,
                alt: 'A 3D model of Lymphatics of Head and Neck',
                autoPlay: true,
                autoRotate: true,
                cameraControls: true,
              ),
            ),
            // Add your content here, such as text, images, or diagrams.
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
                            'Permanent Dentition',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Description of permanent dentition and its significance in dental health and development.',
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
                            '• Permanent teeth: The permanent dentition consists of 32 teeth, including incisors, canines, premolars, and molars.\n'
                            '• Functions: Permanent teeth are essential for biting, chewing, and maintaining proper dental alignment.\n'
                            '• Growth and development: Understanding permanent dentition is crucial in pediatric and orthodontic dentistry.\n',
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

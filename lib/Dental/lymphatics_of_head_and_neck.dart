import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class LymphaticsOfHeadAndNeck extends StatefulWidget {
  LymphaticsOfHeadAndNeck({Key? key}) : super(key: key);

  @override
  _LymphaticsOfHeadAndNeckState createState() =>
      _LymphaticsOfHeadAndNeckState();
}

class _LymphaticsOfHeadAndNeckState extends State<LymphaticsOfHeadAndNeck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lymphatics of Head and Neck'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ModelViewer(
                src: 'assets/medical/Dentist/lymphatics_of_head_and_neck.glb',
                ar: true,
                alt: 'A 3D model of Lymphatics of Head and Neck',
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
                            'Lymphatics of Head and Neck',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'The lymphatics of the head and neck are a vital part of the lymphatic system. They play a crucial role in the immune system and fluid balance within the human body.',
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
                            '• Lymph nodes: The head and neck contain numerous lymph nodes that filter lymphatic fluid and trap harmful substances.\n'
                            '• Drainage patterns: Understanding the drainage patterns of the lymphatics is essential for diagnosing and treating diseases.\n'
                            '• Immune function: Lymphatic vessels in this region contribute to the body\'s defense against infections and diseases.\n'
                            '• Clinical significance: Changes in the lymphatics of the head and neck can have diagnostic implications for healthcare professionals.\n',
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

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class LateralPterygoid extends StatefulWidget {
  LateralPterygoid({Key? key}) : super(key: key);

  @override
  _LateralPterygoidState createState() => _LateralPterygoidState();
}

class _LateralPterygoidState extends State<LateralPterygoid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lateral Pterygoid Muscle'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ModelViewer(
                src: 'assets/medical/Dentist/lateral_pterygoid.glb',
                ar: true,
                alt: 'A 3D model of Lateral Pterygoid Muscle',
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
                            'Lateral Pterygoid Muscle',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'The lateral pterygoid muscle is a jaw muscle that plays a crucial role '
                            'in the movement and function of the temporomandibular joint (TMJ). It is '
                            'responsible for tasks such as opening the jaw, moving it forward, and '
                            'side-to-side motions. Understanding the lateral pterygoid muscle is '
                            'essential in the study of jaw function and dental health.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Function and Anatomy',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• Opens the jaw\n'
                            '• Moves the jaw forward and sideways\n'
                            '• Essential for chewing and speaking\n'
                            '• Consists of two heads: superior and inferior\n',
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

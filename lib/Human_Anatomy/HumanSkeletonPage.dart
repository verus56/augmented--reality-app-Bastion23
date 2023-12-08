import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class HumanSkeletonPage extends StatefulWidget {
  HumanSkeletonPage({Key? key}) : super(key: key);

  @override
  _HumanSkeletonPageState createState() => _HumanSkeletonPageState();
}

class _HumanSkeletonPageState extends State<HumanSkeletonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Human Skeleton'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Add a 3D model here if available. Replace 'model_url_here' with the actual model URL.
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ModelViewer(
                src: 'assets/medical/human_skeleton.glb', // Add your 3D model URL
                ar: true,
                alt: 'A 3D model of the Human Skeleton',
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
                            'Human Skeleton',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Description of the human skeleton and its significance in anatomy and biology.',
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
                            '• The human skeleton is the internal framework of the body consisting of bones and cartilage.\n'
                            '• Function: It provides support, protection for vital organs, and facilitates movement.\n'
                            '• Significance: Understanding the human skeleton is essential in anatomy, medicine, and biology.\n',
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

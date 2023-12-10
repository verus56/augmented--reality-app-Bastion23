import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Screens/home_page.dart';
import 'introduction_animation/introduction_animation_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';
late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AR App',
        home: IntroductionAnimationScreen(),
      ),
      designSize: const Size(390, 844),
    );
  }
}

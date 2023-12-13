import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wallpaper/Screens/navigation.dart';
import 'Screens/home_page.dart';
import 'introduction_animation/introduction_animation_screen.dart';

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
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AR App',
        home: FutureBuilder<User?>(
  // Check if the user is already signed in
  future: FirebaseAuth.instance.authStateChanges().first,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      // Check if the user is signed in
      if (snapshot.data == null) {
        // User is not signed in, show introduction animation
        return IntroductionAnimationScreen();
      } else {
        // User is signed in, show the main navigation screen
        return drawer();
      }
    } else {
      // Loading state, show loading indicator or another splash screen
      return CoolCircularProgressIndicator();
    }
  },
),
      ),
      designSize: const Size(390, 844),
    );
  }
}

class CoolCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

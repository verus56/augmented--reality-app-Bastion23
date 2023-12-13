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
        home: FutureBuilder<UserCredential>(
          // Check if the user is already signed in
          future: FirebaseAuth.instance.signInAnonymously(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Check if the user is signed in
              if (snapshot.hasError || snapshot.data?.user == null) {
                // User is not signed in, show introduction animation
                return IntroductionAnimationScreen();
              } else {
                // User is signed in, show the main navigation screen
                return drawer();
              }
            } else {
              // Loading state, show loading indicator or another splash screen
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      designSize: const Size(390, 844),
    );
  }
}

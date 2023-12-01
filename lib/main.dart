import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/Screens/splachscreen.dart';
import 'Screens/splachscreen.dart';
import 'Screens/welcome.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) =>  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AR App',
        home: IntroScreen(),
        routes: {
           'welcome': (context) => WelcomeScreen(),
        },
      ),
      designSize: const Size(390, 844),
    );
  }
}

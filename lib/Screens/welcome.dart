import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/Screens/sigin.dart';
import 'package:wallpaper/Screens/signup.dart';
import 'package:wallpaper/utils/colors.dart';
import 'package:wallpaper/widgets/other_signin_widget.dart';

import '../widgets/background_image.dart';
import '../widgets/customBtn_widget.dart';
import '../widgets/or_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundWidget(),
          Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              const Text(
                "WELCOME",
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: "mont",
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                "Augement reality app",
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: "mont",
                    color: pinkColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 200.h,
              ),
              Padding(
                padding: EdgeInsets.all(20.h),
                child: const Text(
                  "Join us now to get the best experience",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "mont",
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomBtn(
                    text: "Sign In",
                    color: pinkColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ));
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: CustomBtn(
                    text: "Sign Up",
                    color: blackColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ));
                    }),
              ),
              const OrWidget(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: OtherSignIn(),
              )
            ],
          ),
        ],
      ),
    ));
  }
}

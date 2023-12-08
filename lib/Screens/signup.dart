// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/Screens/sigin.dart';
import 'package:wallpaper/utils/colors.dart';
import 'package:wallpaper/widgets/background_image.dart';
import 'package:wallpaper/widgets/customBtn_widget.dart';
import 'package:wallpaper/widgets/have_account.dart';

import '../widgets/signup_body.dart';
import 'welcome.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BackgroundWidget(),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    Text("Sign Up",
                        style: TextStyle(
                            fontFamily: "mont",
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("Lorem ipsum dolar sit amet",
                        style: TextStyle(
                            fontFamily: "mont",
                            fontSize: 20,
                            color: pinkColor,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: SignUpBody(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: HaveAccountWidget(haveAccount: true),
                    )
                  ],
                ),
              ),
              Positioned(
                  left: 60.w,
                  right: 60.w,
                  top: 625.h,
                  child: CustomBtn(
                      text: "Register", color: pinkColor, onTap: () {})),
            ],
          ),
        ),
      ),
    );
  }
}

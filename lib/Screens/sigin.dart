// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/Screens/navigation.dart';
import 'package:wallpaper/widgets/background_image.dart';
import 'package:wallpaper/widgets/customBtn_widget.dart';

import '../utils/colors.dart';
import '../widgets/have_account.dart';
import '../widgets/signin_body.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            BackgroundWidget(),
            Column(
              children: [
                SizedBox(
                  height: 300.h,
                ),
                Text("Sign In",
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: SignInBody(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: HaveAccountWidget(haveAccount: false),
                )
              ],
            ),
            Positioned(
              left: 60.w,
              right: 60.w,
              top: 630.h,
              child: CustomBtn(
                  text: "Sign In",
                  color: pinkColor,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationPage()))),
            ),
          ],
        ),
      ),
    );
  }
}

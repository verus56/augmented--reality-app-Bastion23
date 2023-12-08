import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/utils/colors.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double sizeHeight = MediaQuery.of(context).size.height;
    // double sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: 270.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Container(
                height: 60.h,
                width: double.infinity - 20.w,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    color: greyColor),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Center(
                  child: TextFormField(
                    cursorColor: pinkColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: pinkColor.withOpacity(.5),
                      ),
                      labelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: blackColor.withOpacity(
                            0.5,
                          ),
                          fontFamily: "mont",
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      labelText: "Email",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Container(
                height: 60.h,
                width: double.infinity - 20.w,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    color: greyColor),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Center(
                  child: TextFormField(
                    cursorColor: pinkColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: pinkColor.withOpacity(.5),
                      ),
                      labelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: blackColor.withOpacity(
                            0.5,
                          ),
                          fontFamily: "mont",
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      labelText: "Password",
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: pinkColor.withOpacity(0.5),
                    fontFamily: "mont",
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

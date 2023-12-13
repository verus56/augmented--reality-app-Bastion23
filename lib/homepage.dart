
import '/models/startup_post.dart';


import '/Posts/post_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Posts/camera_screen.dart';
import 'package:wallpaper/Screens/social.dart';



class pagen extends StatefulWidget {
  const pagen({Key? key}) : super(key: key);
  @override
  State<pagen> createState() => _stateExampleState();
}

// ignore: camel_case_types
class _stateExampleState extends State<pagen> {

  int currentIndex = 1;

  var Tabs = [
    social(),
    CameraScreen(),
    //ProfilePage()
  ];
  final List<Widget> pages = [ social(),CameraScreen(), ];

  PageController pageController = PageController(initialPage: 0);


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:Stack(
             children: [
               IndexedStack(
                 index: currentIndex,
                 children: pages,
               ),
               /*PageView(
                 controller: pageController,
                 onPageChanged: (newIndex){
                   setState(() {
                     currentIndex = newIndex;
                   });
                 },
                 children: [
                   Home(),
                   CameraScreen(),
                   ProfilePage(),
                 ],
               ),*/

             ],
          )
        ),
      );
  }
}











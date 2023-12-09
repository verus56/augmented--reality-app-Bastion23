import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:core';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wallpaper/Screens/getPosts.dart';
import '../Screens/social.dart';
class social extends StatefulWidget {
  const social({Key? key}) : super(key: key);

  @override
  State<social> createState() => _socialState();
}

class _socialState extends State<social> {
  @override
  void initState() {
    //getDocID();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(milliseconds: 5000));
  }

  final user = FirebaseAuth.instance.currentUser;
  // document IDs
  List<String> docIDs = [];
  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection("posts")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print("--------------------");
              print("--------------------");
              print(document.reference);
              print("--------------------");
              print("--------------------");
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    const HeaderColors = [Colors.black, Colors.yellow, Colors.blue, Colors.red];

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocID(),
                builder:(context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: getPosts(documentID: docIDs[index]),
                    );
                  },
                );},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
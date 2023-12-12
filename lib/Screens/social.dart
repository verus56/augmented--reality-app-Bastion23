import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/Screens/getPosts.dart';

class social extends StatefulWidget {
  const social({Key? key}) : super(key: key);

  @override
  State<social> createState() => _socialState();
}

class _socialState extends State<social> {
  final user = FirebaseAuth.instance.currentUser;
  List<String> docIDs = [];

  @override
  void initState() {
    getDocID();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(milliseconds: 5000));
  }

  Future<void> getDocID() async {
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
    double ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 0, bottom: 0),
          child: ListView.builder(
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: getPosts(documentID: docIDs[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
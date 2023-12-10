
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/homepage.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

        Navigator.pushNamed(context, 'home');

  }


  @override
  Widget build(BuildContext context) {

    return Container();
  }


}

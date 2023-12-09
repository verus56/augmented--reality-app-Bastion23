import 'package:get/get.dart';
import 'package:wallpaper/Screens/navigation.dart';

import '/login/services/auth_service.dart';
import '/Screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/login/components/signup_button.dart';
import '/login/pages/login_page.dart';
import '/login/components/my_textfield.dart';
import '/login/components/square_tile.dart';
import '../../introduction_animation/introduction_animation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  // sign user in method
  dynamic signUserUp(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    void showErrorMessage(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ));
        },
      );
    }

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords do not match");
      return;
    }

    try {
      print('signUserUp function called');
      // Create a user in Firebase
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // add user details to firestore
      addUserDetails(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          userNameController.text.trim(),
          emailController.text.trim());

      print('User signed up successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => NavigationPage()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the dialog
      showErrorMessage(e.code);
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String userName, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': firstName,
      'firstname': lastName,
      'lastname': userName,
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      // welcome back, you've been missed!
                      const Text(
                        'Let\'s Create An Account For You!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Inter'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      // username textfield
                      MyTextField(
                        controller: userNameController,
                        hintText: 'Username',
                        obscureText: false,
                      ),
         SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      MyTextField(
                        controller: firstNameController,
                        hintText: 'First Name',
                        obscureText: false,
                      ),
                     SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      MyTextField(
                        controller: lastNameController,
                        hintText: 'Last Name',
                        obscureText: false,
                      ),
            SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                     SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                     SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      // password textfield
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                     SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      // sign in button
                      SignupButton(
                        onTap: () {
                          signUserUp(context);
                        },
                      ),
                        SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      // or continue with
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Inter'),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // google + apple sign in buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // google button
                          SquareTile(
                              onTap: () =>
                                  AuthService().signInWithGoogle(context),
                              imagePath: 'assets/images/google.png'),
                          SizedBox(width: 25),
                          // apple button
                          SquareTile(
                              onTap: () {},
                              imagePath: 'assets/images/apple.png')
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // not a member? register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a member?',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

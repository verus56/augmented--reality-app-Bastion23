
import 'package:wallpaper/Screens/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/login/pages/signup_page.dart';
import '/login/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/login/components/signin_button.dart';
import '/login/components/my_textfield.dart';
import '/login/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

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

 void signUserIn(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    print('signUserIn function called');
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // Access the User object
    User? user = userCredential.user;

    if (user != null) {
      // Print the user ID
      print('User ID: ${user.uid}');

      // Create a Firestore collection for the user
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        // Add more fields as needed
      });

      print('User collection created successfully');
    }

    print('User signed in successfully');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => NavigationPage(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); // Close the dialog
    showErrorMessage(e.code);
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff79794f),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupPage(),
                ),
              );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  // logo
                  SizedBox(
                    height: 200,
                    width: 350,
                    child: Image.asset('assets/images/login_image.png'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // welcome back, you've been missed!
                  const Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, fontFamily: 'Inter'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // username textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // sign in button
                  SigninButton(
                    onTap: () => signUserIn(context),
                  ),

                  const SizedBox(
                    height: 50,
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
                              color: Colors.white,
                              fontFamily: 'Inter',
                            ),
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
                    children:  [
                      // google button
                      SquareTile(
                        onTap: () => AuthService().signInWithGoogle(context),
                        imagePath: 'assets/images/google.png'),
                      SizedBox(width: 25),
                      // apple button
                      SquareTile(
                        onTap: () {},
                        imagePath: 'assets/images/apple.png')
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Inter'),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
                        },
                        child: Text(
                          'Register Now',
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
      ),
    );
  }
}

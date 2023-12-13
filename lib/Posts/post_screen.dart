import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallpaper/Screens/home_page.dart';
import 'package:wallpaper/Screens/navigation.dart';
import 'package:wallpaper/Screens/social.dart';
import '/homepage.dart';
import '/models/startup_post.dart';

class PostScreen extends StatefulWidget {
  PostScreen(this.capturedImage, {Key? key}) : super(key: key);
  final String capturedImage;

  @override
  State<PostScreen> createState() => PostPage();
}

class PostPage extends State<PostScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String imageUrl = '';
  bool showLoading = false;
  DateTime dateTime = DateTime.now();

  late TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    imageUrl = widget.capturedImage; // Set the initial value of imageUrl
  }

  Future<String> selectImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (file != null) {
      print("File path: " + file.path);
      return file.path;
    } else {
      print('No image selected.');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String currentDate = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.brown.shade100,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Create a Post"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        File(widget.capturedImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: captionController,
                    decoration: InputDecoration(
                      hintText: 'Write a Caption...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.show');
                    },
                  ),
                  SizedBox(height: height * 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          imageUrl = await selectImageFromGallery();
                          print(imageUrl);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 187, 170, 165),
                          onPrimary: Colors.white,
                        ),
                        icon: Icon(Icons.photo),
                        label: Text("Gallery"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          imageUrl = await selectImageFromCamera();
                          print(imageUrl);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 187, 170, 165),
                          onPrimary: Colors.white,
                        ),
                        icon: Icon(Icons.camera_alt),
                        label: Text("Camera"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      createPost(captionController.text, imageUrl, currentDate);
                       Get.to(social());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 187, 170, 165),
                      onPrimary: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Post Your Image"),
                        SizedBox(width: 10),
                        if (showLoading) CircularProgressIndicator(),

                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future selectImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      print("File path: " + file.path);
      return file.path;
    } else {
      return '';
    }
  }

  void createPost(String caption, String imageUrl, String date) async {
    if (imageUrl == '' || imageUrl == null) {
      imageUrl = widget.capturedImage;
    }
    try {
      // Upload image to Firebase Storage
      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child("images/$imageFileName");
      UploadTask uploadTask = storageReference.putFile(File(imageUrl));

      await uploadTask.whenComplete(() async {
        // Get the URL of the uploaded image
        imageUrl = await storageReference.getDownloadURL();
      });

      // Create a new document in Firestore
      DocumentReference postDocRef =
          FirebaseFirestore.instance.collection("posts").doc();

      await postDocRef.set({
        "caption": caption,
        "imageUrl": imageUrl,
        "timeStamp": date,
        "likes": 0,
        "userId": user.uid,
      });

      Get.to(pagen());
    } catch (e) {
      print(e.toString());
      print("Cannot make it !!!");
    }
  }
}

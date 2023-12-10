import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

    imageUrl = widget.capturedImage; // Set initial value of imageUrl
    print("-------------------------");
    print("-------------------------");
    print("-------------------------");
    print("-------------------------");
    print("l'image de image Url init est ");
    print(imageUrl);
    print(widget.capturedImage);
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
      //https://upload.wikimedia.org/wikipedia/commons/d/dc/Palais_des_Rais_%28Es%27hine%29_-_Alger.JPG
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String currentDate = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    late String imageUrl = '';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(pagen());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(pagen());
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 5),
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 0),
                                child: Text(
                                  "Create a Post",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FittedBox(
                      child: Image.file(File(widget.capturedImage)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  child: TextFormField(
                    controller: captionController,
                    decoration: InputDecoration(
                      hintText: 'Write a Caption...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.show');
                  },
                ),
                SizedBox(height: height * 0.22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        width: width * 0.45,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Gallery",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                      onTap: () async {
                        imageUrl = await selectImageFromGallery();
                        print(imageUrl);
                      },
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      child: Container(
                        width: width * 0.45,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Camera",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                      onTap: () async {
                        imageUrl = await selectImageFromCamera();
                        print(imageUrl);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.only(left: 40),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Post Your Image",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  height: 25,
                                  width: 25,
                                  child: Center(
                                    child: showLoading
                                        ? CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          )
                                        : Text(''),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          createPost(
                              captionController.text, imageUrl, currentDate);
                        },
                      ),
                    ),
                  ],
                ),
              ],
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
    print("-------------------");
    print("-------------------");
    print("-------------------");
    print("Creating post...");
    print(widget.capturedImage);
    if(imageUrl=='' ||imageUrl==Null ){
      imageUrl=widget.capturedImage;
      print("imageUrl=widget.capturedImage");
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

      print("Image uploaded successfully");

      // Create a new document in Firestore
      DocumentReference postDocRef =
          FirebaseFirestore.instance.collection("posts").doc();

      print("Document created successfully");
      print("Document ID: " + postDocRef.id);
      print("Caption: " + caption);
      print("Image URL: " + imageUrl);
      print("Date: " + date);
      print("User ID: " + user.uid);

      await postDocRef.set({
        "caption": caption,
        "imageUrl": imageUrl,
        "timeStamp": date,
        "likes": 0,
        "userId": user.uid,
      });

      Get.to(pagen());
      print("Successfully posted");
    } catch (e) {
      print(e.toString());
      print("Cannot make it !!!");
    }
  }
}

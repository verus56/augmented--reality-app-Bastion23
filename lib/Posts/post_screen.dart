import 'dart:async';

import 'dart:io';

import '/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/models/startup_post.dart';

class PostScreen extends StatefulWidget {
  PostScreen(this.CapturedImage, {super.key});
  String CapturedImage;

  @override
  State<PostScreen> createState() => PostPage();
}

class PostPage extends State<PostScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  //  ${user.uid}
  String imageUrl = '';
  String selectedimage = "";
  bool showLoading = false;
  String UserId = "";
  String timestamp = '';
  DateTime dateTime = DateTime.now();

  var Post = post(
    name: "User",
    caption: "",
    image: 'url',
  );

  @override
  void initState() {
    super.initState();
    postImage(widget.CapturedImage);
  }

  late TextEditingController CaptionController = TextEditingController();
Future<String> selectImageFromGallery() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 60,
  );

  if (file != null) {
    print("File path: " + file.path);
    setState(() {
      selectedimage = file.path; // Use lowercase "i"
    });
    return file.path;
  } else {
    print('No image selected.');
    return 'https://upload.wikimedia.org/wikipedia/commons/d/dc/Palais_des_Rais_%28Es%27hine%29_-_Alger.JPG';
  }
}


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String CurrentDate = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

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
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 0),
                            child: Text(
                              "Create a Post",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
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
                      child: Image.file(File(widget.CapturedImage)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  child: TextFormField(
                    controller: CaptionController,
                    decoration: InputDecoration(
                      hintText: 'Write a Caption...',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15)),
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
                SizedBox(
                  height: height * 0.22,
                ),
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
                            )),
                        child: Center(
                          child: Text(
                            "Gallery",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                      onTap: () async {
                        selectedimage =
                            await selectImageFromGallery(); 
                        postImage(selectedimage);
                        

                        print(imageUrl);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Container(
                        width: width * 0.45,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            )),
                        child: const Center(
                          child: Text(
                            "Camera",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                      onTap: () async {
                        selectedimage =
                            await selectImageFromCamera(); // Use lowercase "i"
                        postImage(selectedimage);

                        print(imageUrl);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
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
                                SizedBox(
                                  width: 15,
                                ),
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
                          createPost(Post, imageUrl, CaptionController.text,
                              CurrentDate);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    // Function to post image in firebase Storage
  }

  Future selectImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      print("File path: " + file.path);
      setState(() {
        if (file.path != null) {
          selectedimage = file.path;
        }
      });
      return file.path;
    } else {
      return '';
    }
  }

  Future postImage(file) async {
    String url = "";
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child('post_images')
        .child(uniqueFileName);
    setState(() {
      showLoading = true;
    });
    await ref.putFile(File(file));
    url = await ref.getDownloadURL();

    setState(() {
      showLoading = false;
    });
    imageUrl = url;
    print("URL is : " + url);
  }

  // Function to insert data into firebase firestore
  void createPost(Post, ImageUrl, caption, Date) async {
    final PostDocId = FirebaseFirestore.instance.collection("posts").doc();
    Get.snackbar(
      "Please Wait ! ",
      "Posting ...",
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.startToEnd,
      icon: Icon(
        Icons.send_rounded,
        color: Colors.white,
      ),
      showProgressIndicator: false,
    );

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    print(timestamp);
    print("User ID is : " + user.uid);
    print("Image URL is : " + imageUrl);
    print("Caption is : " + caption);
    print("Date is : " + Date);

    try {
      await PostDocId.set({
        "caption": caption,
        "image": imageUrl,
        "TimeStamp": timestamp,
        "likes": 0,
        "UserId": user.uid,
      });
      Get.to(pagen());
      print("Successfully posted ");
    } catch (e) {
      print(e.toString());
      print("Cannot make it !!!");
    }
  }
}

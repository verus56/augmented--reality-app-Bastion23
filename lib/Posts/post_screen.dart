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

class PostScreen extends StatefulWidget{
  PostScreen(this.CapturedImage,{super.key});
  String CapturedImage;


  @override
  State<PostScreen> createState() => PostPage();

}


class PostPage extends State<PostScreen>{
  String imageUrl = '';
  String selectedimage = "";
  bool showLoading = false;
  var UserPhoneNumber = '';
  var UserName = '';
  String UserId = "";
  String UserProfileImage = "";
  String timestamp = '';
  DateTime dateTime = DateTime.now();



  var Post = post(
      name: "User",
      caption: "", image: 'url',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserData();
    postImage(widget.CapturedImage);

  }

  Future getuserData() async{
    //Code to Get UID of current user
    final FirebaseAuth CurrUser = FirebaseAuth.instance;
    final User? user = CurrUser.currentUser;
    final uid = user?.uid;
    // code to get current user details
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    Map<String,dynamic>? data = docSnapshot.data();
    Timer(Duration(milliseconds: 1500), (){
      setState(() {
        UserName = data?['Name'];
        UserPhoneNumber = data?['Phone'];
        UserId = data?['id'];
        UserProfileImage = data?['ProfileImage'];
        timestamp = Timestamp.now().toString();
      });
    });
  }

  late TextEditingController CaptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String CurrentDate = '${dateTime.year}-${dateTime.month}-${dateTime.day}';




    return Scaffold(
      body:SafeArea(
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
                          child:Row(
                            children: [
                              IconButton(
                                  onPressed: (){
                                    Get.to(pagen());
                                  },
                                  icon: Icon(Icons.arrow_back_rounded,color: Colors.black,size: 30,)
                              ),
                              SizedBox(width: 5,),
                              Padding(
                                  padding: EdgeInsets.only(left:20,top:0),
                                  child: Text("Create a Post",style: TextStyle(fontSize: 25),),
                                ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Container(
                      height: 450,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    child: FittedBox(
                      child: Image.file(File(widget.CapturedImage)),
                      fit: BoxFit.cover,
                    ),
                  ) ,
                ),
                SizedBox(height:10),
                InkWell(
                  child: TextFormField(
                    controller: CaptionController,
                    decoration:InputDecoration(
                      hintText: 'Write a Caption...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  onTap: (){
                    SystemChannels.textInput.invokeMethod('TextInput.show');
                  },
                ),
                SizedBox(height: height*0.22,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child:Container(
                        width:width*0.45,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            )
                        ),
                        child: Center(
                          child: Text("Gallery",style: TextStyle(color: Colors.black,fontSize: 20),),
                        ),
                      ),
                      onTap: ()async{
                        selectedimage = await selectImageFromGallery();
                        postImage(selectedimage);
                        print(imageUrl);
                      },
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      child:Container(
                        width: width*0.45,
                        height: 50,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )
                        ),
                        child: const Center(
                          child: Text("Camera",style: TextStyle(color: Colors.black,fontSize: 20),),
                        ),
                      ),
                      onTap: () async{
                        selectedimage = await selectImageFromCamera();
                        postImage(selectedimage);
                        print(imageUrl);

                      },
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child:Container(
                          padding: EdgeInsets.only(left: 40),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:CrossAxisAlignment.center,
                              children: [
                                Text("Post ur expreince",style: TextStyle(color: Colors.white,fontSize: 20),),
                                SizedBox(width: 15,),
                                Container(
                                  height: 25,
                                  width: 25,
                                  child:Center(
                                    child: showLoading ? CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ) : Text(''),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          createPost(Post, imageUrl,CaptionController.text,CurrentDate);
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


  Future selectImageFromGallery() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 60);
    if(file != null){
      print("File path: "+file.path);
      setState(() {
        if(file.path != null){
          selectedimage = file.path;
        }
      });
      return file.path;
    }else{
      return '';
    }
  }



  Future selectImageFromCamera() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if(file != null){
      print("File path: "+file.path);
      setState(() {
        if(file.path != null){
          selectedimage = file.path;
        }
      });
      return file.path;
    }else{
      return '';
    }
  }


  Future postImage(file) async {
    String url = "";
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child('post_images').child(uniqueFileName);
    setState(() {
      showLoading = true;
    });
    await ref.putFile(File(file));
    url = await ref.getDownloadURL();

    setState(() {
      showLoading = false;
    });
    imageUrl = url;
    print("URL is : "+url);
  }




  // Function to insert data into firebase firestore
  void createPost(Post,ImageUrl,caption,Date) async{
    final UserPostDocId = FirebaseFirestore.instance.collection('users').doc(UserId).collection('UserPosts').doc();
    final PostDocId = FirebaseFirestore.instance.collection("posts").doc();
    Get.snackbar("Please Wait ! ", "Posting ...",
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackStyle:SnackStyle.FLOATING,
      dismissDirection: DismissDirection.startToEnd,
      icon: Icon(Icons.send_rounded,color: Colors.white,),
      showProgressIndicator: false,

    );
    //await postImage(widget.CapturedImage);
    var check=0;
    try{
      await PostDocId.set({
        "Name":UserName,
        "Phone":UserPhoneNumber,
        "caption": caption,
        "image" :imageUrl,
        "ProfileImage": UserProfileImage,
        "TimeStamp":timestamp,
        "CurrentDate":Date,
        "likes":0,
        "CurrentDocumentId":PostDocId.id,
      });
      await UserPostDocId.set({
        "Name":UserName,
        "Phone":UserPhoneNumber,
        "caption": caption,
        "image" :imageUrl,
        "ProfileImage": UserProfileImage,
        "TimeStamp": timestamp,
        "CurrentDate":Date,
        "PostDocumentId":PostDocId.id,
        "CurrentDocumentId":UserPostDocId.id,
        "likes":0,
      });

      Get.to(pagen());
    }catch(e){
      print(e.toString());
      print("cannot make it !!!");
    }
    if(check==1) print("Successully posted ");
  }





















  /*Future OpenCamera() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    print('${file?.path}');
    if(file==null) return;
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('post_images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try{
      referenceImageToUpload.putFile(File(file!.path));
      imageUrl = (await referenceImageToUpload.getDownloadURL()).toString();
      print("urllll"+imageUrl);
      await FirebaseFirestore.instance.collection("startup").doc().set({
        "Name":"User",
        "caption":'this is a post',
        "image" :imageUrl,
      });



    }catch(e){
      print(e.toString());
    }
  }*/


}









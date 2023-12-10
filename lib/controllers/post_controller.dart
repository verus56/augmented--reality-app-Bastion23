import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class postController extends GetxController{
  /*void createPost(Post,ImageUrl,caption) async{
    Get.snackbar("Please Wait ! ", "Posting ...",
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black,
      colorText: Colors.white,
      snackStyle:SnackStyle.FLOATING,
      dismissDirection: DismissDirection.startToEnd,
      icon: Icon(Icons.send_rounded,color: Colors.white,),
      showProgressIndicator: false,

    );
    var check=0;
    try{
      await FirebaseFirestore.instance.collection("posts").doc().set({
        "Name":UserName,
        "Phone":UserPhoneNumber,
        "caption": caption,
        "image" :imageUrl,
        "ProfileImage": UserProfileImage,
        "TimeStamp": TimeStamp,
      });
      Get.to(HomePage());
    }catch(e){
      print(e.toString());
      print("cannot make it !!!");
    }
    if(check==1) print("Successully posted ");
  }*/

}
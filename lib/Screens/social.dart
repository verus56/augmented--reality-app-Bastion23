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


class social extends StatefulWidget {
  const social({Key? key}) : super(key: key);

  @override
  State<social> createState() => _socialState();
}

class _socialState extends State<social> {

  String imageUrl = '';
  String caption = '';
  int likes = 0 ;
  String UserId = '';




  @override
  void initState() {
    super.initState();

    //fetchData();
  }


  Future getuserData() async {
    //Code to Get UID of current user
    final FirebaseAuth CurrUser = FirebaseAuth.instance;
    final User? user = CurrUser.currentUser;
    final uid = user?.uid;
    // code to get current user details
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    Map<String, dynamic>? data = docSnapshot.data();
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        UserId = data?['id'];
      });
    });
  }

  Future<void> _handleRefresh() async{
    return await Future.delayed(Duration(milliseconds: 500));
  }


  @override
  Widget build(BuildContext context) {
    const HeaderColors = [Colors.black,Colors.yellow,Colors.blue,Colors.red];


    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    DateTime now = new DateTime.now();
    DateTime Date = DateTime(now.day, now.month, now.year);



    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                          height: 45,
                          padding: EdgeInsets.only(left: 12,top: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,

                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:5),
                            child: AnimatedTextKit(
                              animatedTexts: [ColorizeAnimatedText("share ur expreince", textStyle:TextStyle(fontSize: 25,letterSpacing: 1,), colors: HeaderColors,)],
                              repeatForever: false,
                              pause: Duration(milliseconds: 1000),

                            ),
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.only(top: 0,bottom: 0),
                height: ScreenHeight*0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                ),
                child: LiquidPullToRefresh(
                  onRefresh: _handleRefresh,
                  child: fetchData(ScreenHeight,UserId),
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  animSpeedFactor: 10,
                ),
              )
            ],
          )
      ),
    );
  }
}



Widget fetchData(ScreenHeight,UserId){
  var likes = 0;
  String DocumentId = '';
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("posts").orderBy("TimeStamp",descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text("Something wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:CupertinoActivityIndicator(),
          );
        }
        if(snapshot.data!.docs.isEmpty){
          return Text("No Data found");
        }
        if(snapshot != null && snapshot.data != null){
          return ListView.builder(
            itemExtent: 810,
            //scrollDirection: Axis.vertical
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              likes = snapshot.data!.docs[index]['likes'];
              DocumentId = snapshot.data!.docs[index]['CurrentDocumentId'];
              return Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Container(
                          height: ScreenHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center ,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 6,),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: CachedNetworkImage(
                                      imageUrl:snapshot.data!.docs[index]['ProfileImage'],
                                      imageBuilder: (context, imageProvider) => Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                      errorWidget: (context,url,error) =>Image(image: AssetImage('assets/images/auth_images/startup.png')),
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontSize: 16),),
                                      SizedBox(height: 3,),
                                      Text("Raghu Institute of Technology",style: TextStyle(color: Colors.grey.shade500,fontSize: 12),),
                                    ],
                                  ),
                                  SizedBox(width: 80,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 27),
                                    child: Text(snapshot.data!.docs[index]['CurrentDate'],style: TextStyle(fontSize: 12,color: Colors.grey.shade400,
                                    ),),
                                  )
                                ],
                              ),
                              SizedBox(height: 8,),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: InkWell(
                                        child: Container(
                                          height:640,

                                          child: AspectRatio(
                                            aspectRatio: 100/9,
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data!.docs[index]['image'],
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: 550,
                                                decoration: BoxDecoration(

                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8)),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill,
                                                    )
                                                ),
                                              ),
                                              placeholder: (context,url) => Container(
                                                alignment:Alignment.center,
                                                child: LoadingAnimationWidget.beat(color: Colors.grey.shade300, size: 50),
                                              ),
                                              errorWidget: (context,url,error) =>Image(image: AssetImage('assets/images/auth_images/startup.png')),


                                            ),
                                          ),
                                        ),
                                        onDoubleTap: (){
                                          print("Double Tap .........");
                                          LikePost(likes, DocumentId);
                                        },
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child:Container(
                                                    height: 20,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 2,),
                                                        Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: InkWell(
                                                            child: LikeButton(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              countPostion: CountPostion.right,
                                                              likeCount:snapshot.data!.docs[index]['likes'],
                                                              size: 30,
                                                            ),
                                                            onTap: () async{
                                                              await LikePost(likes,DocumentId);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10,top: 2),
                                                          child: Icon(Icons.comment,color: Colors.grey,size: 30,),
                                                        ),

                                                      ],
                                                    ),
                                                  )
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 12,),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(6),
                                                child: Text(snapshot.data!.docs[index]['caption']),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                ],
              );
            },
          );
        }
        //Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontSize: 12),),
        return Container();
      }
  );
}


LikePost(likes,DocumentId) async{
  try {
    await FirebaseFirestore.instance.collection("posts").doc(DocumentId).update({
      "likes": likes,
    });
  } catch (e) {
    print(e.toString());
    print("cannot make it !!!");
  }

}
































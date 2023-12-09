import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:like_button/like_button.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class getPosts extends StatefulWidget {
  final String documentID;

  getPosts({required this.documentID});

  @override
  _getPostsState createState() => _getPostsState();
}

class _getPostsState extends State<getPosts> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.documentID)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            imageUrl: data["imageUrl"],
                            imageBuilder: (context, imageProvider) => Container(
                              width: 100.0,
                              height: 350.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        onDoubleTap: () {
                          print("Double Tap .........");
                          //LikePost(likes, DocumentId);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        color: Colors.grey.shade50,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, top: 2),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: LikeButton(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          countPostion: CountPostion.right,
                                          //likeCount:snapshot.data!.docs[index]['likes'],
                                          size: 30,
                                        ),
                                        onTap: () {
                                          // await LikePost(likes,DocumentId);
                                          print("Like");
                                        },
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 2),
                                        child: Icon(
                                          Icons.comment,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    data["caption"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    data["caption"],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                //Text(data["TimeStamp"]),
                //Text(data["UserId"]),
                //Text(data["likes"]),
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}

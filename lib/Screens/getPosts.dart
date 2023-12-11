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
  Future<String> getUserName(String userID) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .get();

      if (snapshot.exists) {
        return snapshot.get("username") ?? "User0001";
      } else {
        return "User0001";
      }
    } catch (e) {
      // Handle any errors that might occur during the data fetching.
      print("Error fetching username: $e");
      return "User0001";
    }
  }

  Future<String> getUserAvatar(String userID) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .get();

      if (snapshot.exists) {
        return snapshot.get("avatar") ??
            "https://cdn.britannica.com/34/3034-050-077DE27D/Flag-Algeria.jpg";
      } else {
        return "https://cdn.britannica.com/34/3034-050-077DE27D/Flag-Algeria.jpg";
      }
    } catch (e) {
      // Handle any errors that might occur during the data fetching.
      print("Error fetching username: $e");
      return "https://cdn.britannica.com/34/3034-050-077DE27D/Flag-Algeria.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.documentID)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        print("we are here");
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // padding only in the top and bottom
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FutureBuilder<String>(
                            future: getUserAvatar(data["userId"]),
                            builder: (context, avatarSnapshot) {
                              return CircleAvatar(
                                radius: 20,
                                backgroundImage: avatarSnapshot.hasData
                                    ? Image.network(
                                        avatarSnapshot.data ?? "",
                                        fit: BoxFit.cover,
                                      ).image
                                    : Image.network(
                                        "https://cdn.britannica.com/34/3034-050-077DE27D/Flag-Algeria.jpg",
                                        fit: BoxFit.cover,
                                      ).image,
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FutureBuilder<String>(
                            future: getUserName(data["userId"]),
                            builder: (context, usernameSnapshot) {
                              return Text(
                                usernameSnapshot.data ?? "User0001",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ],
                      ),
                      Icon(Icons.menu),
                    ],
                  ),
                ),
                Container(
                  height: 400.0, // Set a fixed height
                  child: InkWell(
                    child: CachedNetworkImage(
                      imageUrl: data["imageUrl"],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    onDoubleTap: () {
                      print("Double Tap .........");
                      // LikePost(likes, DocumentId);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(Icons.chat_bubble_outline),
                          ), // Padding
                          Icon(Icons.share),
                        ],
                      ),
                      Icon(Icons.bookmark),
                    ],
                  ),
                ),
                Text(
                  '${data["likes"]} likes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: FutureBuilder<String>(
                    future: getUserName(data["userId"]),
                    builder: (context, usernameSnapshot) {
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: usernameSnapshot.data ?? "User0001",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: ' ${data["caption"]}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        //data["username"],
                        "username",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Icon(Icons.menu),
                ],
              ),
            ),
            Container(
              height: 400,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(Icons.chat_bubble_outline),
                      ), // Padding
                      Icon(Icons.share),
                    ],
                  ),
                  Icon(Icons.bookmark),
                ],
              ),
            ),
            Text(
              'likes',
              //'Liked by ${data["likes"]}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "username  ",
                      //'${data["username"]}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: " caption",
                      //'${data["caption"]}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

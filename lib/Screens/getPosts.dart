import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            child: Column(
              children: [
                //Text(data["TimeStamp"]),
                //Text(data["UserId"]),
                Image.network(
                  data["imageUrl"],
                  width: 100, // Set the width as needed
                  height: 100, // Set the height as needed
                  fit: BoxFit.cover, // Set the BoxFit as needed
                ),
                Text(data["caption"]),
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

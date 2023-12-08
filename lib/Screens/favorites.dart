import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late User? currentUser;
  late CollectionReference favoritesCollection;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Access the 'favorites' subcollection within the user's document
      favoritesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('favorites');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: currentUser == null
          ? Center(
              child: Text('User not authenticated'),
            )
          : StreamBuilder(
              // Use a stream builder to listen for changes in the favorites collection
              stream: favoritesCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No favorites yet'),
                  );
                } else {
                  // Display the list of favorite images
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // Extract the imageUrl from the document
         
Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
String imageUrl = data['imageUrl'] as String;

// Display the image (you can use any widget here)
return Image.asset(imageUrl);
                    },
                  );
                }
              },
            ),
    );
  }
}

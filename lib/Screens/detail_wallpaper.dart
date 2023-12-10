import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper/Screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailWallpaper extends StatefulWidget {
  final ImageDetails imageDetails;
  final String commonAudioPath;

  DetailWallpaper({
    Key? key,
    required this.imageDetails,
    required this.commonAudioPath,
  }) : super(key: key);

  @override
  _DetailWallpaperState createState() => _DetailWallpaperState();
}

class _DetailWallpaperState extends State<DetailWallpaper> {
  late AudioPlayer _audioPlayer;

  Future<void> _saveImageToGallery() async {
    try {
      if (await Permission.storage.request().isGranted) {
        // Permission is granted, proceed with saving the image to the gallery
        await GallerySaver.saveImage(
          widget.imageDetails.imagePath,
          albumName: "CustomAlbumName", // Replace with your custom album name
        );
        print("Image saved to gallery successfully");
      } else {
        // Permission is not granted. Handle accordingly.
        print("Permission denied to save image to gallery");
      }
    } catch (e) {
      print("Error saving image to gallery: $e");
    }
  }

void addToFavorites(String imageUrl) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Access the 'favorites' subcollection within the user's document
    CollectionReference favoritesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites');

    // Check if the image is already in favorites
    QuerySnapshot existingImages = await favoritesCollection
        .where('imageUrl', isEqualTo: imageUrl)
        .get();

    if (existingImages.docs.isEmpty) {
      // If the image is not in favorites, add it
      await favoritesCollection.add({
        'imageUrl': imageUrl,
        // Add more fields as needed
      });

      print('Image added to favorites successfully');
    } else {
      // If the image is already in favorites, you can handle it accordingly
      print('Image is already in favorites');
    }
  }
}


  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    _playAudio();
  }

  _initAudio() async {
    try {
      await _audioPlayer.setAsset(widget.commonAudioPath);
    } catch (e) {
      print("Error initializing audio: $e");
    }
  }

  _playAudio() async {
    try {
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imageDetails.imagePath,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageDetails.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: sizeWidth * 1,
            height: sizeHeight * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                  Colors.black,
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 200,
            child: Text(
              widget.imageDetails.title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "mont",
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 120,
            child: Text(
              widget.imageDetails.description,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "mont",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 15,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                primary: Color.fromARGB(255, 77, 74, 52),
                fixedSize: const Size(180, 50),
              ),
              onPressed: _saveImageToGallery,
              child: Text(
                "download",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "mont",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 15,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                  color: Color.fromARGB(255, 59, 53, 75),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.share,
                size: 25,
                color: Color.fromARGB(255, 59, 53, 75),
              ),
            ),
          ),
         
           Positioned(
  bottom: 50,
  right: 80,
  child: IconButton(
    icon: Icon(
      Icons.favorite,
      size: 25,
      color: Color.fromARGB(255, 59, 53, 75),
    ),
    onPressed: () => addToFavorites(widget.imageDetails.imagePath),
  ),
),
          
        ],
      ),
    );
  }
}
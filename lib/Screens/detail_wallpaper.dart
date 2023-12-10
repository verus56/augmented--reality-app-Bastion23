import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:gallery_saver/gallery_saver.dart' ;
import 'package:wallpaper/Screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


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
 bool isAddedToFavorites = false;
 bool isDownloaded = false;
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


Future<void> downloadImage(String assetPath) async {
  try {
    // Check and request permissions
    if (await Permission.storage.request().isGranted) {
      // Get the external storage directory
      final directory = await getExternalStorageDirectory();
      final picturesDirectory = Directory('${directory?.path}/Pictures');

      if (!picturesDirectory.existsSync()) {
        picturesDirectory.createSync(recursive: true);
      }

      if (directory != null) {
        // Extract the file name from the asset path
        final fileName = assetPath.split('/').last;

        // Create a file to save the downloaded image
        final file = File('${picturesDirectory.path}/$fileName');

        // Read the asset bytes
        final ByteData data = await rootBundle.load(assetPath);
        final List<int> bytes = data.buffer.asUint8List();

        // Write the asset bytes to the file
        await file.writeAsBytes(bytes);

        print('Image downloaded and saved at: ${file.path}');
        // Provide feedback to the user if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image downloaded and saved at: ${file.path}')),
        );
      } else {
        print('External storage directory is null');
        // Handle the case where external storage directory is not available
      }
    } else {
      // Prompt the user to grant permission or provide feedback
      print('Permission not granted');
    }
  } catch (e) {
    // Handle any exceptions that might occur during the process
    print('Error: $e');
    // Provide feedback to the user if needed
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
                  borderRadius: BorderRadius.circular(15.0),
                ),
                primary: isDownloaded
                    ? Color.fromARGB(255, 77, 22, 22) // Change color when downloaded
                    : Color.fromARGB(255, 77, 74, 52),
                fixedSize: const Size(180, 50),
              ),
              onPressed: () {
                // Update the button state and trigger the download
                setState(() {
                  isDownloaded = true;
                });
                downloadImage(widget.imageDetails.imagePath);
              },
              child: Text(
                isDownloaded ? "Downloaded" : "Download",
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
            right: 80,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                size: 25,
                color: isAddedToFavorites
                    ? Color.fromARGB(255, 101, 51, 42) // Change color when added to favorites
                    : Color.fromARGB(255, 59, 53, 75),
              ),
              onPressed: () {
                // Update the icon state and trigger addToFavorites
                setState(() {
                  isAddedToFavorites = !isAddedToFavorites;
                });
                addToFavorites(widget.imageDetails.imagePath);
              },
            ),
          ),
          
        ],
      ),
    );
  }
}
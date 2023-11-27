import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../utils/colors.dart';

class DetailWallpaper extends StatefulWidget {
  String image;
  DetailWallpaper({Key? key, required this.image}) : super(key: key);

  @override
  _DetailWallpaperState createState() => _DetailWallpaperState();
}

class _DetailWallpaperState extends State<DetailWallpaper> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  _playBackgroundMusic() async {
    await _audioPlayer.play('assets/music/senya.mp3', isLocal: true);
  }

  verify() {
    setState(() {
      _isLoading = true;
    });
    const oneSec = Duration(milliseconds: 1000);
  }

  bool _isLoading = false;
  bool _isVerified = false;
  String _code = '';

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.image,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.image.toString()),
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
              "Wall On Hand",
              style: TextStyle(
                color: pinkColor,
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
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla fermentum som a vehicula iaculis. Donec a risus nec arcu placerat tempus.",
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
                primary: pinkColor,
                fixedSize: const Size(180, 50),
              ),
              onPressed: _code.length == 1
                  ? null
                  : () {
                verify();
              },
              child: _isLoading
                  ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
                  : _isVerified
                  ? Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 30,
              )
                  : Text(
                "Download",
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
                  color: pinkColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.share,
                size: 25,
                color: pinkColor,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 80,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                  color: pinkColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.favorite,
                size: 25,
                color: pinkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

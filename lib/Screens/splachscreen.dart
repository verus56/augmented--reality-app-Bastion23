import 'data.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  late PageController _controller;
  late AudioPlayer _audioPlayer;

  List<String> wallpaperUrls = [
    'https://i.postimg.cc/Jh8vTW8L/maisons-des-pecheurs.jpg',
    'https://i.postimg.cc/2jFRY8zg/Palais-des-Rais01.jpg',
    'https://i.postimg.cc/gJsXFbrR/bastion-23.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  _playBackgroundMusic() async {
    await _audioPlayer.setAsset('assets/1.mp3');
    _audioPlayer.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose(); // Dispose of the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(wallpaperUrls[currentIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // PageView Content
            PageView.builder(
              controller: _controller,
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Text(
                        "Bastion23",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 253, 253),
                          letterSpacing: 1,
                          fontSize: 60,
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Center(
                        child: Text(
                          details[index].desc,
                          softWrap: true,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 251, 251, 251)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                details[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 21,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Bastion AR is an assistant app that helps you check the amazing pictures of the Baston 23 museum.',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      3,
                                      (index) => Container(
                                        height: 5,
                                        width: currentIndex == index ? 20 : 8,
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              255, 185, 168, 122),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  index == 2
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              'welcome',
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                  255, 185, 168, 122),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _controller.nextPage(
                                              duration:
                                                  Duration(milliseconds: 100),
                                              curve: Curves.bounceIn,
                                            );
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Skip",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Icon(Icons.arrow_forward),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

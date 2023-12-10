import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/Screens/favorites.dart';
import 'package:wallpaper/Screens/home_page.dart';
import 'package:wallpaper/Screens/camerapage.dart';
import 'package:wallpaper/Posts/camera_screen.dart';
import 'package:wallpaper/Screens/social.dart';
import '../utils/colors.dart';
import 'package:wallpaper/ArtScreen/arhome.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late PageController _pageController;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceIn,
    );
  }

  Widget page(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "mont",
            fontWeight: FontWeight.bold,
            color: blackColor,
            fontSize: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomePage(),

                FavoritesPage(),
                CameraScreen(),
                social(),
                ArHome(),

              ],
            ),
            // Bottom Navigation
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Container(
                decoration: BoxDecoration(
                  color: pinkColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: CupertinoTabBar(
                    border: const Border(top: BorderSide(color: pinkColor)),
                    backgroundColor: pinkColor,
                    currentIndex: pageIndex,
                    iconSize: 20.0, // Adjust the iconSize here
                    inactiveColor: Colors.white,
                    onTap: onTap,
                    activeColor: blackColor,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                      ),
                      BottomNavigationBarItem(icon: Icon(Icons.video_stable)),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.now_wallpaper)),
                      BottomNavigationBarItem(icon: Icon(Icons.camera)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper/Screens/favorites.dart';
import 'package:wallpaper/Screens/home_page.dart';
import 'package:wallpaper/Screens/camerapage.dart';
import 'package:wallpaper/Posts/camera_screen.dart';
import 'package:wallpaper/Screens/social.dart';
import 'package:wallpaper/ArtScreen/arhome.dart';


class drawer extends StatefulWidget {
  const drawer({Key? key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  final zoomDrawerController = ZoomDrawerController();
  List<String> screenStringTest = ["Home", "Favorites", "AR", "Camera", "Post"];
  List<IconData> screenIconTest = [
    Icons.apps,
    Icons.favorite,
    Icons.star,
    Icons.camera,
    Icons.post_add,
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuBackgroundColor: Color.fromARGB(255, 246, 244, 244),
      shadowLayer1Color: const Color.fromARGB(255, 245, 245, 245),
      shadowLayer2Color:
          Color.fromARGB(255, 139, 125, 125).withOpacity(0.3),
      borderRadius: 50.0,
      showShadow: true,
      mainScreen: _buildMainScreen(context),
      menuScreen: _menuScreen(context),
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }

  Scaffold _buildMainScreen(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
    
      body: _buildBody(selectedIndex),
      
      
  
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Color.fromARGB(255, 103, 83, 83),
        selectedItemColor: Color.fromARGB(255, 43, 38, 38),
        selectedFontSize: 14.0,
        selectedIconTheme: const IconThemeData(size: 28.0),
        unselectedIconTheme: IconThemeData(size: 25.0, color: Colors.grey[500]),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: List.generate(
          screenStringTest.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(screenIconTest[index]),
            label: screenStringTest[index],
          ),

        ),
      ),
    );
  }

  Container _menuScreen(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                zoomDrawerController.toggle?.call();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CircleAvatar(
                        foregroundImage: AssetImage("assets/profile.jpg"),
                        radius: 50,
                        backgroundColor: Color.fromARGB(255, 82, 81, 86),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(5, (index) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          zoomDrawerController.toggle?.call();
                        },
                        splashColor:
                            Theme.of(context).primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        child: ListTile(
                          leading: Icon(
                            screenIconTest[index],
                            color: Colors.black,
                            size: 27,
                          ),
                          title: Text(
                            screenStringTest[index],
                            style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 70),
                  child: TextButton.icon(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor.withOpacity(0.5)),
                      side: MaterialStateProperty.all(
                        BorderSide(
                            color: Colors.black.withOpacity(0.5), width: 1.5),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Icon(
                        Icons.logout,
                        color:  Colors.black,
                      ),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(int selectedIndex) {
    // Replace this switch statement with the specific pages you want to display
    switch (selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return FavoritesPage();
   
      case 2:
        return  ArHome();
      case 3:
        return  CameraScreen();
       case 4:
        return  social();
     
  
     
      default:
        return HomePage();
    }
  }

AppBar buildAppBar() {
  return AppBar(
   
    elevation: 0, // No shadow
    leading: IconButton(
      onPressed: () => zoomDrawerController.toggle?.call(),
      icon: const Icon(Icons.menu),
    ),
  
    
  );
}
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/colors.dart';
import 'detail_wallpaper.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List wallpaperList = [
    "1.jpg",
    "2.jpg",
    "3.jpg",
    "4.jpg",
    "5.jpg",
    "6.jpg",
    "7.jpg",
    "8.jpg",
    "9.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          const ListTile(
            title: Text(
              "bab el oued",
              style: TextStyle(
                  fontFamily: "mont",
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                  fontSize: 35),
            ),
            subtitle: Text(
              "Clique and join us now",
              style: TextStyle(
                  fontFamily: "mont",
                  fontWeight: FontWeight.bold,
                  color: pinkColor,
                  fontSize: 30),
            ),
          ),
          StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(8.0),
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: wallpaperList.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailWallpaper(image: "assets/${i + 1}.jpg"))),
                child: Hero(
                  tag: "assets/$i.jpg",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage(
                      image: AssetImage("assets/${i + 1}.jpg"),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage("assets/wp.png"),
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (i) =>
                StaggeredTile.count(2, i.isEven ? 2 : 3),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          )
        ],
      ),
    );
  }
}

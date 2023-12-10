import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/Screens/detail_wallpaper.dart';

class ImageDetails {
  final String imagePath;
  final String title;
  final String description;

  ImageDetails({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<ImageDetails> imageDetailsList = [
    ImageDetails(
      imagePath: "assets/1.jpg",
      title: "Palace of the Rais (Q'asr Rouy')",
      description:
          "This 16th-century palace is the largest and most impressive of the three.",
    ),
    ImageDetails(
      imagePath: "assets/2.jpg",
      title: "Palace of Ahmed Bey",
      description:
          " This 17th-century palace is known for its intimate and serene atmosphere..",
    ),
    ImageDetails(
      imagePath: "assets/3.jpg",
      title: "Palace of Hussein Dey",
      description:
          " This 18th-century palace is the smallest and most modern of the three.",
    ),
    ImageDetails(
      imagePath: "assets/4.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),
    ImageDetails(
      imagePath: "assets/5.jpg",
      title: "Title 1",
      description: "Description for image 1.",
    ),
    ImageDetails(
      imagePath: "assets/6.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),
    ImageDetails(
      imagePath: "assets/7.jpg",
      title: "Title 1",
      description: "Description for image 1.",
    ),
    ImageDetails(
      imagePath: "assets/8.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),
    ImageDetails(
      imagePath: "assets/12.JPG",
      title: "Title 1",
      description: "Description for image 1.",
    ),
    ImageDetails(
      imagePath: "assets/1.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),
    // Add more entries for each image
  ];
  final commonAudioPath1 = "assets/anta-hobi-al-awal-lefqirat.mp3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/r.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              ListTile(
                title: Text(
                  "Hello there",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 209, 185, 185),
                    fontSize: 45,
                  ),
                ),
                subtitle: Text(
                  "You in the mood for some historical art?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
        
        
  Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/r.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
               
                         ],
          ),
        ),
      ),
            
   Container ( 
   
     child:   StaggeredGridView.countBuilder(
                    padding: const EdgeInsets.all(8.0),
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imageDetailsList.length,
                    itemBuilder: (context, i) {
                     return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailWallpaper(
                      imageDetails: imageDetailsList[i],
                      commonAudioPath: commonAudioPath1
                    ),
                  ),
                ),
                child: Hero(
                  tag: imageDetailsList[i].imagePath,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage(
                      image: AssetImage(imageDetailsList[i].imagePath),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage("assets/images.png"),
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
             )   ],
              ),
               ))) 

               ;
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(12.0),
        child: Icon(Icons.menu, color: Colors.white),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: IconButton(
            onPressed: () {
              // Handle search button tap
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

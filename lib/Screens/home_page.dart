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
      title: "Palace of the Rais",
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
      title: "Inside architecture",
      description: "This is an 18th-century ottoman style inside architecture of the roof and windows of the Bastion.",
    ),
    ImageDetails(
      imagePath: "assets/5.jpg",
      title: "Lightening inside the Bastion",
      description: "During the Ottoman ruling it was known to use lanterns and handmade chandeliers that color and shape the lights beautifully around the walls of the Bastion.",
    ),
    ImageDetails(
      imagePath: "assets/6.jpg",
      title: "Chandelier",
      description: "This is an example of the chandeliers used in the Bastion and their play on lights.",
    ),
    ImageDetails(
      imagePath: "assets/7.jpg",
      title: "Museum",
      description: "This is the exhibition of the algerian culture held in the basement of Palace 18, where it showcases the Diffrent dresses worn traditionally by the Algerian men and wormen.",
    ),
    ImageDetails(
      imagePath: "assets/10.JPG",
      title: "Patio (wast eddar)",
      description: "in the Palace of the Rais (Q' asr Rouy') or Bastion 23, Algiers. Algeria, 16th-18th century.",
    ),
    ImageDetails(
      imagePath: "assets/12.JPG",
      title: "House of the Caid",
      description: "This 17th-century house was home to the military governor of the city",
    ),
    ImageDetails(
      imagePath: "assets/11.JPG",
      title: "Sea view",
      description: "This is the outside of the Bastion 23 that overlooks the sea with an architecture made to face dangerous threats.",
    ),
    ImageDetails(
      imagePath: "assets/16.jpg",
      title: "Water fountain",
      description: "This is a water fountain decorating the inside of the 3 palaces of the Bastion 23.",
    ),
    ImageDetails(
      imagePath: "assets/13.JPG",
      title: "Upper view the Bastion 23",
      description: "This is the architecture of the Bastion 23 with its overview on the sea, and connection of the 3 palaces with the 6 houses.",
    ),
    ImageDetails(
      imagePath: "assets/14.JPG",
      title: "Tunnel",
      description: "This is the tunnel connecting the Three palaces with six houses, completing the build of the Bastion 23.",
    ),
    ImageDetails(
      imagePath: "assets/15.jpg",
      title: "Halls",
      description: "This is the Halls of the palaces showcasing the amazing Ottoman art with diffrent types of chandeliers, zellige tilework and mashrabiya screens",
    ),
  ];
  final commonAudioPath1 = "assets/anta-hobi-al-awal-lefqirat.mp3";
   final double menuWidthScale = 0.8;
    final double scaleY = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      
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
                      placeholder: const AssetImage("assets/Solid_white.png"),
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
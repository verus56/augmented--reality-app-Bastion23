import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'detail_wallpaper.dart';
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

 String commonAudioPath1 = "assets/anta-hobi-al-awal-lefqirat.mp3"; // Update with your audio path

 
 List<ImageDetails> imageDetailsList = [
    ImageDetails(
      imagePath: "assets/1.jpg",
      title: "Title 1",
      description: "Description for image 1.",
    ),
    ImageDetails(
      imagePath: "assets/2.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),
       ImageDetails(
      imagePath: "assets/3.jpg",
      title: "Title 1",
      description: "Description for image 1.",
    ),
    ImageDetails(
      imagePath: "assets/4.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),   ImageDetails(
      imagePath: "assets/5.jpg",
      title: "Title 1",
      description: "Description for image 1.",
    ),
    ImageDetails(
      imagePath: "assets/6.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),   ImageDetails(
      imagePath: "assets/7.jpg",
      title: "Title 1",
      description: "Description for image 1.",
    ),
    ImageDetails(
      imagePath: "assets/8.jpg",
      title: "Title 2",
      description: "Description for image 2.",
    ),   ImageDetails(
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

  @override
  Widget build(BuildContext context) {
      return Scaffold(
    
      body: SingleChildScrollView(
        child: Column(
   
     
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          const ListTile(
            title: Text(
              "Palais Rias Al Bahr",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),
            ),
            subtitle: Text(
              "enjoy your visit",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color.fromARGB(255, 113, 116, 144), fontSize: 30),
            ),
          ),
          StaggeredGridView.countBuilder(
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
       ) );
  }
}
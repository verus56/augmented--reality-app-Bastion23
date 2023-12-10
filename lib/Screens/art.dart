


import '/Dental/Lateral_Pterygoid.dart';
import '/Dental/lymphatics_of_head_and_neck.dart';
import '/Dental/permanent_dentition.dart';
import '/Dental/primary_lower_left_first_molar_fdi.dart';
import '/Dental/primary_lower_left_canine_fdi.dart';
// primary_upper_left_canine
import '/Dental/primary_upper_left_canine.dart';
import '/Human_Anatomy/ChloeFranckAnatomyPage.dart';
import '/Human_Anatomy/HumanSkeletonPage.dart';
import '/Human_Anatomy/XRayTorsoPage.dart';
import '/Human_Anatomy/female_anatomy.dart';
import 'package:flutter/material.dart';


class art extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dental',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Colors.orangeAccent, // light blue
                          Colors.orangeAccent, // medium blue
                          Colors.orangeAccent, // deep blue
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(Rect.fromLTRB(0, 0, 0,
                          40)), // change the last value to increase/decrease the height of the gradient effect
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("View all");
                    // Your function here
                  },
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                    height: 180,
                    child: Row(
                      children: <Widget>[
                        _buildCard(
                          'https://i0.wp.com/occlusionconnections.com/wp-content/uploads/2016/01/lateral-pterygoid-muscle.png?ssl=1',
                          'Lateral Pterygoid',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LateralPterygoid(),
                              ),
                            );
                          },
                        ),
                        _buildCard(
                          'https://images.squarespace-cdn.com/content/v1/5c76c60a65019f7d9e58c1ae/1573155720448-762N5ZLYY5NHAE21VPNP/1395w1elg.jpg',
                          'Lymphatics',
                              () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LymphaticsOfHeadAndNeck(),
                            ),
                          ),
                        ),
                        _buildCard(
                          'https://medlineplus.gov/ency/images/ency/fullsize/18162.jpg',
                          'Dentition',
                              () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PermanentDentition(),
                            ),
                          ),
                        ),
                        _buildCard(
                          'https://media.sketchfab.com/models/7af5b4caf60f4453a4142b6845b9d898/thumbnails/0215895d8a654a3a8fa4fced4e784df9/fc509bdc24434fc6895a4ca284c71e05.jpeg',
                          'Lower leftcanine ',
                              () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrimaryLowerLeftCanine(),
                            ),
                          ),
                        ),
                        _buildCard(
                          'https://media.sketchfab.com/models/4b693b87f0504c5c8b507bf4b9360ad0/thumbnails/0fdad15b2ee94164bbb2842935d1b55d/08c104aaca8e4fa2bc696bfe52eef53a.jpeg',
                          'Lower first molar ',
                              () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PrimaryLowerLeftFirstMolar(),
                            ),
                          ),
                        ),
                        _buildCard(
                          'https://media.sketchfab.com/models/905b91b732504abc8e0923c70cbe7efa/thumbnails/8964d0f169a740fcbdc8bc10bb3582ee/7c6fc6cfeb924e1bba43e8b8b54468d4.jpeg',
                          'Upper Left Canine ',
                              () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrimaryUpperLeftCanine(),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Divider(),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                  children: [
                    TextSpan(text: 'Human Anatomy'),
                    WidgetSpan(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        // children: [
                        //   Image.network(
                        //     'https://www.pngall.com/wp-content/uploads/2017/05/Save-Earth-PNG-Picture.png',
                        //     width: 30, // set the width of the image
                        //     height: 30, // set the height of the image
                        //     fit: BoxFit.cover,
                        //   ),
                        //   // SizedBox(width: 8),
                        //   // Text('India'),
                        // ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Wrap(
                  spacing: 16, // spacing between cards
                  runSpacing: 16, // spacing between rows
                  children: [
                    _buildCard(
                      'https://media.sketchfab.com/models/640d69d4da994c3ca23a5e35d950d5be/thumbnails/6f5b1434d81940c18da57beb2993f85e/3b056472187e428fad81678c7f464d3d.jpeg',
                      ' Chloe Franck',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChloeFranckAnatomyPage(),
                          ),
                        );
                      },
                    ),
                    _buildCard(
                      'https://m.media-amazon.com/images/I/41+P0zlNzpL._AC_UF894,1000_QL80_.jpg',
                      'Female Anatomy ',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FemaleAnatomy2Page(),
                          ),
                        );
                      },
                    ),
                    _buildCard(
                      'https://media.istockphoto.com/id/135853422/photo/male-human-skeleton-four-views-front-back-side-and-perspective.jpg?s=612x612&w=0&k=20&c=gUCB4KvmGpGgXIlj9822yGQ8sP_k-Uj29FQnKkvgXuE=',
                      'Human Skleton',
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HumanSkeletonPage(),
                        ),
                      ),
                    ),
                    _buildCard(
                      'https://media.istockphoto.com/id/1203743434/photo/x-ray-of-a-man-u2019s-body-spine-pelvic-bones-ribs-internal-organs.jpg?s=612x612&w=0&k=20&c=V_6BjCoSQocNM5xvps0LkgmEqI7h0P-t0BNbFXp7oAU=',
                      'X-ray Torso',
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => XRayTorsoPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Top Brands',
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.orangeAccent),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         print("View all");
              //         // Your function here
              //       },
              //       child: Row(
              //         children: [
              //           Text(
              //             'View All',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.grey[600],
              //             ),
              //           ),
              //           Icon(
              //             Icons.arrow_forward_ios,
              //             color: Colors.grey[600],
              //             size: 16,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: SizedBox(
              //       height: 180,
              //       child: Row(
              //         children: <Widget>[
              //           _buildCard(
              //             'https://cdni.autocarindia.com/ExtraImages/20220211050819_Alfa_Romeo_Giulia_GTA.jpg',
              //             'MC Laren',
              //             () => Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Alfaromeo6c(),
              //               ),
              //             ),
              //           ),
              //           _buildCard(
              //             'https://imgd-ct.aeplcdn.com/1056x660/n/jkpj3sa_1483580.jpg?q=75',
              //             'Jaguar F-Type',
              //             () => Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => jhtype(),
              //               ),
              //             ),
              //           ),
              //           _buildCard(
              //             'https://stimg.cardekho.com/images/carexteriorimages/930x620/Ferrari/SF90-Stradale/7858/1591681679806/front-view-118.jpg',
              //             'Ferrari',
              //             () => Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Ferari(),
              //               ),
              //             ),
              //           ),
              //           _buildCard(
              //             'https://www.ford.com/is/image/content/dam/vdm_ford/live/en_us/ford/nameplate/mustang/2023/collections/dm/22_FRD_MST_55079_C7447317_MUST_GT_Prem_34FrntPassMotnRain_mj.tif?croppathe=1_3x2&wid=900',
              //             'Ford Mastang',
              //             () => Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Product6(),
              //               ),
              //             ),
              //           ),
              //         ],
              //       )),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String imgUrl, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                imgUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


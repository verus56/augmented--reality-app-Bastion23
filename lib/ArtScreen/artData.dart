class ArData {
  ArData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = "",
    required this.modelPath,
  });
  String modelPath;
  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  String perNight;

  static List<ArData> homeList = <ArData>[
    ArData(
      imagePath: 'assets/1.jpg',
      titleTxt: 'AR Baba',
      subTxt: 'Try our AR  baba',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/group.glb',
    ),
    ArData(
      imagePath: 'assets/2.jpg',
      titleTxt: 'Planet ',
      subTxt: 'blablaba.',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: "Play",
      modelPath: 'assets/Model/Totoro.glb',
      //   // perNight: "Play",
    ),
    ArData(
      imagePath: 'assets/2.jpg',
      titleTxt: 'kach haja',
      subTxt: 'kdkd',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/Totoro.glb',
    ),
    // ArData(
    //   imagePath: 'assets/ArHome/home_2.png',
    //   titleTxt: 'Renewable Quest',
    //   subTxt: 'Save the kingdom with renewable energy',
    //   dist: 2.0,
    //   reviews: 240,
    //   rating: 4.5,
    //   // perNight: "Play",
    // ),
  ];
}

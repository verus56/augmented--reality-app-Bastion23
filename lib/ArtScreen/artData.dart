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
      titleTxt: 'Bastion 23 ',
      subTxt: 'Try our AR Bastion',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/ImageToStl.com_bastion_24_1.glb',
    ),
    ArData(
      imagePath: 'assets/8.jpg',
      titleTxt: 'Wall ',
      subTxt: 'Show Wall now.',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: "Play",
      modelPath: 'assets/Model/smata.glb',
      //   // perNight: "Play",
    ),
    ArData(
      imagePath: 'assets/4.jpg',
      titleTxt: 'Roof ',
      subTxt: 'show Roof now',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/roof.glb',
    ),
    ArData(
      imagePath: 'assets/window.png',
      titleTxt: 'window ',
      subTxt: 'Fenetre ',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/fenetre.glb',
    ),
    ArData(
      imagePath: 'assets/door2.png',
      titleTxt: ' secondary door',
      subTxt: ' secondary door ',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/porte.glb',
    ),
    ArData(
      imagePath: 'assets/door1.png',
      titleTxt: 'prinicipal door',
      subTxt: 'principal door',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/porte_principal.glb',
    ),
    ArData(
      imagePath: 'assets/Model/lus.jpg',
      titleTxt: 'chandelier',
      subTxt: 'chandelier',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: "Play",
      modelPath: 'assets/Model/lustre.glb',
    ),
  ];
}

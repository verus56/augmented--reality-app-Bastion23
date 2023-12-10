import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: sizeWidth * 1,
      height: sizeHeight * 1,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/ok.png",
              ),
              fit: BoxFit.cover)),
    );
  }
}

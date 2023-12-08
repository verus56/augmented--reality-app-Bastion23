import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(
              child: Container(
                  padding: const EdgeInsets.only(top: 140),
                  constraints: BoxConstraints(maxWidth: 350, maxHeight: 350),
                 
                ),
            ),
            Padding(
              padding: EdgeInsets.only( left: 64, right: 64 , top: 10.0, bottom: 8.0),
              child: Text(
                "Bastion23",
                style: TextStyle(fontSize: 55.0, fontWeight: FontWeight.w700, fontFamily: 'Inter', color: Color.fromARGB(255, 224, 210, 210)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                "you want to have some fun at the bastion 23 musuem ?",
                    style: TextStyle(color: Color.fromARGB(182, 246, 246, 246),fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter',),
                    textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 18,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Colors.white,
                  ),
                  child: Text(
                    "Let's begin",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Color(0xff132137),
                    ),
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
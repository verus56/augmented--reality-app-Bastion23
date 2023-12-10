import 'package:flutter/material.dart';

class OtherSignIn extends StatelessWidget {
  const OtherSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: 140,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.facebook,
                  color: Colors.white,
                ),
                Text("facebook",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "mont",
                        fontWeight: FontWeight.w800,
                        color: Colors.white))
              ],
            )),
        Container(
            width: 140,
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xffEA4335),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 25,
                  height: 30,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/google.png",
                          ),
                          fit: BoxFit.cover)),
                ),
                const Text("Google",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "mont",
                        fontWeight: FontWeight.w800,
                        color: Colors.white))
              ],
            ))
      ],
    );
  }
}

import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: 110,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Text("or sign with",
              style: TextStyle(
                  fontFamily: "mont",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.5))),
        ),
        Container(
          height: 2,
          width: 110,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)),
        ),
      ],
    );
  }
}

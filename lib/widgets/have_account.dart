import 'package:flutter/material.dart';

import '../Screens/sigin.dart';
import '../Screens/signup.dart';
import '../utils/colors.dart';

class HaveAccountWidget extends StatelessWidget {
  bool haveAccount;
  HaveAccountWidget({
    super.key,
    required this.haveAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: Text(
                haveAccount
                    ? "Already have an account? "
                    : "Don't have an account? ",
                style: TextStyle(
                    fontFamily: "mont",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9))),
          ),
          TextButton(
            onPressed: () => haveAccount
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ))
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  )),
            child: Text(haveAccount ? "Sign In" : "Sign Up",
                style: const TextStyle(
                  fontFamily: "mont",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: pinkColor,
                )),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorUtils {
  static dynamic pushReplacement(BuildContext context, Widget nextPage) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => nextPage));
  }

  static dynamic pushReplacementWithAnimation(
      BuildContext context, dynamic animation) {
    Navigator.pushReplacement(context, animation);
  }

  static dynamic pushReplacementWithFadeAnimation(
      BuildContext context, Widget nextPage) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: nextPage,
        alignment: Alignment.topLeft,
        duration: const Duration(seconds: 0, milliseconds: 500),
      ),
    );
  }

  static void push(BuildContext context, Widget nextPage) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
  }

  static void pushNamed(BuildContext context, String namedPath) {
    Navigator.pushNamed(context, namedPath);
  }
}

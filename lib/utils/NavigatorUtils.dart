import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorUtils {
  static dynamic pushReplacementWithFadeAnimation(BuildContext context, Widget nextPage) {
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

  static void pushWithFadeAnimation(BuildContext context, Widget nextPage) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: nextPage,
        alignment: Alignment.topLeft,
        duration: const Duration(seconds: 0, milliseconds: 500),
      ),
    );
  }

  static void pushNamed(BuildContext context, String namedPath) {
    Navigator.pushNamed(context, namedPath);
  }
}

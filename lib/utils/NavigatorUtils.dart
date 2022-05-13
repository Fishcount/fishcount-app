import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtils {
  static void pushReplacement(BuildContext context, Widget nextPage) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => nextPage));
  }

  static void push(BuildContext context, Widget nextPage) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
  }

  static void pushNamed(BuildContext context, String namedPath) {
    Navigator.pushNamed(context, namedPath);
  }
}

import 'package:flutter/material.dart';

class CustomSnackBar {
  static getCustomSnackBar(BuildContext context, String message, Color? color) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "",
          onPressed: () {},
        ),
      ),
    );
  }
}

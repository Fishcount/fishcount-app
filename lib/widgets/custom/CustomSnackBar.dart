import 'package:flutter/material.dart';

class CustomSnackBar {
  static getCustomSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400],
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "",
          onPressed: () {},
        ),
      ),
    );
  }
}

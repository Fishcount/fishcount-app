import 'package:flutter/material.dart';

class SnackBarBuilder {
  String text;

  Color? color;

  SnackBarBuilder.info(
    this.text,
  );

  SnackBarBuilder.error(
    this.text,
    this.color,
  );

  buildError(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "",
          onPressed: () {},
        ),
      ),
    );
  }

  buildInfo(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30,
            ),
            Text(text),
          ],
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "",
          onPressed: () {},
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'buttons/ElevatedButtonWidget.dart';

class AlertDialogWidgetBuilder {
  String title;

  String text;

  String leftButtonText;

  Function() leftButtonFunction;

  String rightButtonText;

  Function() rightButtonFunction;

  AlertDialogWidgetBuilder.confirmDialog({
    required this.title,
    required this.text,
    required this.leftButtonText,
    required this.leftButtonFunction,
    required this.rightButtonText,
    required this.rightButtonFunction,
  });

  Future<String?> build(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                  buttonText: leftButtonText,
                  buttonColor: Colors.blue,
                  onPressed: () => leftButtonFunction,
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
                ElevatedButtonWidget(
                  buttonText: rightButtonText,
                  buttonColor: Colors.green,
                  onPressed: () => rightButtonFunction,
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

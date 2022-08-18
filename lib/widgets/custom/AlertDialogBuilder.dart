import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogBuilder {

  String title;

  String description;

  String leftButtonText;

  Function() leftButtonFunction;

  Color? leftButtonColor;

  String rightButtonText;

  Function() rightButtonFunction;

  Color? rightButtonColor;


  AlertDialogBuilder({
    required this.title,
    required this.description,
    required this.leftButtonText,
    required this.leftButtonFunction,
    this.leftButtonColor,
    required this.rightButtonText,
    required this.rightButtonFunction,
    this.rightButtonColor,
  });

  build(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                  buttonText: leftButtonText,
                  buttonColor: leftButtonColor == null ? Colors.blue : leftButtonColor!,
                  onPressed: leftButtonFunction,
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
                ElevatedButtonWidget(
                  buttonText: rightButtonText,
                  buttonColor: rightButtonColor == null ? Colors.green : rightButtonColor!,
                  onPressed: rightButtonFunction,
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

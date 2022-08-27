import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogBuilder {
  String title;

  String description;

  String? leftButtonText;

  Function()? leftButtonFunction;

  Color? leftButtonColor;

  String? rightButtonText;

  Function()? rightButtonFunction;

  Color? rightButtonColor;

  Widget? bottomElement;

  MainAxisAlignment mainAxisAlignment;

  AlertDialogBuilder({
    required this.title,
    required this.description,
    required this.mainAxisAlignment,
    this.leftButtonText,
    this.leftButtonFunction,
    this.leftButtonColor,
    this.rightButtonText,
    this.rightButtonFunction,
    this.rightButtonColor,
    this.bottomElement,
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
              mainAxisAlignment: mainAxisAlignment,
              children: [
                leftButtonText != null && leftButtonFunction != null
                    ? ElevatedButtonWidget(
                        buttonText: leftButtonText!,
                        buttonColor: leftButtonColor == null
                            ? Colors.blue
                            : leftButtonColor!,
                        onPressed: leftButtonFunction!,
                        textSize: 15,
                        textColor: Colors.white,
                        radioBorder: 10,
                      )
                    : const Text(""),
                rightButtonColor != null && rightButtonFunction != null
                    ? ElevatedButtonWidget(
                        buttonText: rightButtonText!,
                        buttonColor: rightButtonColor == null
                            ? Colors.green
                            : rightButtonColor!,
                        onPressed: rightButtonFunction!,
                        textSize: 15,
                        textColor: Colors.white,
                        radioBorder: 10,
                      )
                    : const Text(""),
                rightButtonFunction == null &&
                        rightButtonFunction == null &&
                        leftButtonFunction == null &&
                        leftButtonFunction == null
                    ? bottomElement ?? const Text("")
                    : const Text(""),
              ],
            )
          ],
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final String buttonText;
  final double textSize;
  final Color textColor;
  final Color buttonColor;
  final Function() onPressed;
  final double radioBorder;
  final double? paddingAll;
  final double? horizontalPadding;
  final double? verticalPadding;

  const ElevatedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
    required this.textSize,
    required this.textColor,
    required this.radioBorder,
    this.paddingAll,
    this.horizontalPadding,
    this.verticalPadding,
  }) : super(key: key);

  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        alignment: Alignment.center,
        visualDensity: VisualDensity.comfortable,
        backgroundColor: MaterialStateProperty.all(widget.buttonColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radioBorder),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: resolvePadding(),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            fontSize: widget.textSize,
            color: widget.textColor,
          ),
        ),
      ),
      onPressed: widget.onPressed,
    );
  }

  EdgeInsets resolvePadding() {
    return widget.paddingAll != null
        ? EdgeInsets.all(widget.paddingAll!)
        : EdgeInsets.only(
            top: widget.verticalPadding != null ? widget.verticalPadding! : 0,
            bottom:
                widget.verticalPadding != null ? widget.verticalPadding! : 0,
            left: widget.horizontalPadding != null
                ? widget.horizontalPadding!
                : 0,
            right: widget.horizontalPadding != null
                ? widget.horizontalPadding!
                : 0,
          );
  }
}

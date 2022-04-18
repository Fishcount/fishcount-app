import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatefulWidget {
  final String buttonText;
  final Color textColor;
  final double textSize;

  const TextButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.textColor,
      required this.textSize})
      : super(key: key);

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        widget.buttonText,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.textSize,
        ),
      ),
      style: const ButtonStyle(
        alignment: Alignment.center,
        visualDensity: VisualDensity.comfortable,
      ),
      onPressed: () {},
    );
  }
}

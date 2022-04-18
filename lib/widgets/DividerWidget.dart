import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final String textBetween;
  final double thikness;
  final double height;
  final Color color;
  final double paddingLeft;
  final double paddingRight;

  const DividerWidget({
    Key? key,
    required this.textBetween,
    required this.height,
    required this.thikness,
    required this.color,
    required this.paddingLeft,
    required this.paddingRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            height: height,
            thickness: thikness,
            color: color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
          ),
          child: Text(
            textBetween,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            height: height,
            thickness: thikness,
            color: color,
          ),
        ),
      ],
    );
  }
}

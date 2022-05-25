import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final String? textBetween;
  final Color? textColor;
  final Widget? widgetBetween;
  final bool? isBold;
  final double thikness;
  final double height;
  final Color color;
  final double paddingLeft;
  final double paddingRight;

  const DividerWidget({
    Key? key,
    this.widgetBetween,
    this.textBetween,
    this.textColor,
    this.isBold,
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
        _getSideLine(),
        Container(
            padding: EdgeInsets.only(
              left: paddingLeft,
              right: paddingRight,
            ),
            child: _getTextOrWidget()),
        _getSideLine(),
      ],
    );
  }

  Expanded _getSideLine() {
    return Expanded(
        child: Divider(
          height: height,
          thickness: thikness,
          color: color,
        ),
      );
  }

  Widget _getTextOrWidget() {
    return widgetBetween == null
        ? Text(
            textBetween == null ? "" : textBetween!,
            style: TextStyle(
              fontSize: 17,
              color: textColor,
              fontWeight: _isBold(),
            ),
          )
        : widgetBetween!;
  }

  FontWeight? _isBold() => isBold != null
      ? isBold!
          ? FontWeight.bold
          : FontWeight.normal
      : null;
}

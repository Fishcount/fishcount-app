import 'package:flutter/cupertino.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final Function() gestureDetectorFunction;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.gestureDetectorFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      onTap: gestureDetectorFunction,
    );
  }
}

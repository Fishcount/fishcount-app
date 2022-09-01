import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../modules/batch/BatchScreen.dart';

class CustomBottomSheet {
  BuildContext context;
  Function() newFunction;
  final Color iconColor = Colors.white;
  final Color textColor = Colors.white;
  final Color bottomSheetColor = Colors.blue[700]!;

  CustomBottomSheet({
    required this.context,
    required this.newFunction,
  });


   build() {
    return MediaQuery.of(context).orientation != Orientation.portrait
        ? null
        : Container(
            color: bottomSheetColor,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.line_style_outlined,
                          size: 35,
                          color: iconColor,
                        ),
                        onTap: () {
                          NavigatorUtils.pushReplacement(
                            context,
                            const BatchScreen(),
                          );
                        },
                      ),
                      Text(
                        "Lotes",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 35,
                        color: iconColor,
                      ),
                      Text(
                        "Análises",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Icon(
                          LineIcons.fish,
                          size: 35,
                          color: iconColor,
                        ),
                        onTap: newFunction,
                      ),
                      Text(
                        "Novo",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

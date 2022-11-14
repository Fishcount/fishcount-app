import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/modules/analisys/AnalysisListScreen.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../modules/batch/BatchScreen.dart';

class CustomBottomSheet {
  BuildContext context;
  Function() newFunction;
  Widget? rightElement;
  Widget? leftElement;
  Widget? centerElement;
  final Color iconColor = Colors.white;
  final Color textColor = Colors.white;
  final Color bottomSheetColor = Colors.blue[700]!;

  CustomBottomSheet({
    required this.context,
    required this.newFunction,
    this.rightElement,
    this.leftElement,
    this.centerElement,
  });

  build({tankModel: TankModel}) {
    return MediaQuery.of(context).orientation != Orientation.portrait
        ? null
        : Container(
            color: bottomSheetColor,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                leftElement ??
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
                              NavigatorUtils.pushReplacementWithFadeAnimation(
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
                centerElement ??
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.analytics_outlined,
                              size: 35,
                              color: iconColor,
                            ),
                            onTap: () => {},
                            // NavigatorUtils.pushReplacement(context,
                            // AnalysisListScreen(tankModel: tankModel)),
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
                rightElement ??
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

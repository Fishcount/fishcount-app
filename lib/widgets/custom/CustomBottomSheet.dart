import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../modules/batch/BatchScreen.dart';

class CustomBottomSheet {
  static Widget getCustomBottomSheet(
      BuildContext context, Function() newFunction) {
    return Container(
      color: Colors.yellow,
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
                  child: const Icon(
                    Icons.line_style_outlined,
                    size: 35,
                    color: Colors.blueAccent,
                  ),
                  onTap: () {
                    NavigatorUtils.pushReplacement(
                      context,
                      const BatchScreen(),
                    );
                  },
                ),
                const Text(
                  "Lotes",
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.analytics_outlined,
                  size: 35,
                  color: Colors.blueAccent,
                ),
                Text(
                  "Análises",
                  style: TextStyle(
                    color: Colors.blueAccent,
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
                  child: const Icon(
                    LineIcons.fish,
                    size: 35,
                    color: Colors.blueAccent,
                  ),
                  onTap: newFunction,
                ),
                const Text(
                  "Novo",
                  style: TextStyle(
                    color: Colors.blueAccent,
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

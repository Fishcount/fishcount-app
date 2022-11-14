import 'package:fishcount_app/constants/AppImages.dart';
import 'package:flutter/material.dart';

class AppBarBuilder {

  final Color backGroundColor = Colors.blue[700]!;
  final double borderRadius = 80;

  AppBarBuilder();

  build() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        centerTitle: true,
        backgroundColor: backGroundColor,
        toolbarHeight: 70,
        title: Container(
          width: 150,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius),
              bottomRight: Radius.circular(borderRadius),
            ),
            shape: BoxShape.rectangle,
            color: Colors.white,
            image: const DecorationImage(
              image: AssetImage(ImagePaths.imageLogo),
              scale: 4.7,
              alignment: Alignment.topCenter,
              fit: BoxFit.scaleDown,
            ),
          ),
          padding: const EdgeInsets.only(top: 1),
        ),
      ),
    );
  }

}

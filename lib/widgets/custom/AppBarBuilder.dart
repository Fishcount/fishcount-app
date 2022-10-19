import 'package:fishcount_app/constants/AppImages.dart';
import 'package:flutter/material.dart';

class AppBarBuilder {

  final Color backGroundColor = Colors.blue[700]!;

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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),
            shape: BoxShape.rectangle,
            color: Colors.white,
            image: DecorationImage(
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

import 'package:fishcount_app/constants/AppImages.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  static PreferredSize getAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        toolbarHeight: 70,
        title: Container(
          width: 150,
          height: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(500),
              bottomRight: Radius.circular(500),
            ),
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(ImagePaths.imageLogo),
              scale: 2.5,
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
            ),
          ),
          padding: const EdgeInsets.only(top: 7),
        ),
      ),
    );
  }
}

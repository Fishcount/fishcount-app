import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AnimationUtils {
  static Widget progressiveDots({size = double}) {
    return LoadingAnimationWidget.prograssiveDots(
        color: Colors.blue, size: size);
  }

  static Widget bouncingBall({size = double}) {
    return LoadingAnimationWidget.bouncingBall(color: Colors.blue, size: size);
  }

  static Widget threeRotatungDots({size = double, color: Colors}) {
    return LoadingAnimationWidget.threeRotatingDots(color: color ?? Colors.blue, size: size);
  }

  static Widget beat({size = double}) {
    return LoadingAnimationWidget.beat(color: Colors.blue, size: size);
  }
}

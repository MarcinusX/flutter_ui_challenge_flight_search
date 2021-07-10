import 'package:flutter/material.dart';

class AnimatedPlaneIcon extends AnimatedWidget {
  final Animation<double> animation;

  AnimatedPlaneIcon({Key? key, required this.animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      size: animation.value,
    );
  }
}

import 'package:flutter/material.dart';

class AnimatedPlaneIcon extends AnimatedWidget {
  AnimatedPlaneIcon({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = super.listenable;
    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      size: animation.value,
    );
  }
}

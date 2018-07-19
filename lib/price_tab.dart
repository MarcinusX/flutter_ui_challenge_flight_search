import 'package:flutter/material.dart';

class PriceTab extends StatefulWidget {
  final VoidCallback onPlaneSizeAnimated;

  const PriceTab({Key key, this.onPlaneSizeAnimated}) : super(key: key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab>
    with SingleTickerProviderStateMixin {
  AnimationController _initialPlainAnimationController;
  Animation<double> _plainSizeAnimation;

  @override
  void initState() {
    super.initState();
    _initialPlainAnimationController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onPlaneSizeAnimated();
        }
      });
    _plainSizeAnimation = new Tween<double>(begin: 60.0, end: 32.0)
        .animate(_initialPlainAnimationController);
    _initialPlainAnimationController.forward();
  }

  @override
  void dispose() {
    _initialPlainAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: _plainSizeAnimation,
            builder: (context, child) => Icon(
                  Icons.airplanemode_active,
                  color: Colors.red,
                  size: _plainSizeAnimation.value,
                ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class PriceTab extends StatefulWidget {
  final double height;
  final VoidCallback onPlaneSizeAnimated;

  const PriceTab({Key key, this.onPlaneSizeAnimated, this.height})
      : super(key: key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {
  AnimationController _initialPlainAnimationController;
  Animation<double> _plainSizeAnimation;
  AnimationController _planeTravelAnimationController;
  Animation<double> _planeTravelAnimation;
  final double _startPaddingBottom = 16.0;
  final double _endPaddingTop = 16.0;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initialPlainAnimationController.forward();
  }

  @override
  void dispose() {
    _initialPlainAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _initialPlainAnimationController.isCompleted
            ? _buildTravelPlaneAnimation()
            : _buildInitialPlaneAnimation(),
      ],
    );
  }

  void _initAnimations() {
    _initInitialAnimation();
    _initPlaneTravelAnimation();
  }

  void _initPlaneTravelAnimation() {
    _planeTravelAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _planeTravelAnimation = CurvedAnimation(
      parent: _planeTravelAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _initInitialAnimation() {
    _initialPlainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onPlaneSizeAnimated();
          _planeTravelAnimationController.forward();
        }
      });
    _plainSizeAnimation = Tween<double>(begin: 60.0, end: 36.0)
        .animate(_initialPlainAnimationController);
  }

  double get _planeTopPadding =>
      _endPaddingTop +
          (1 - _planeTravelAnimation.value) *
              (widget.height - _endPaddingTop - _startPaddingBottom - 40.0);

  Widget _buildTravelPlaneAnimation() {
//    return Container();
    return AnimatedBuilder(
      animation: _planeTravelAnimation,
      builder: (context, child) {
        return Positioned(
          top: _planeTopPadding,
          child: _buildPlaneIcon(),
        );
      },
    );
  }

  Widget _buildPlaneIcon() {
    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      size: _plainSizeAnimation.value,
    );
  }

  Widget _buildInitialPlaneAnimation() {
    return Positioned(
      bottom: _startPaddingBottom,
      child: AnimatedBuilder(
        animation: _plainSizeAnimation,
        builder: (context, child) => _buildPlaneIcon(),
      ),
    );
  }
}

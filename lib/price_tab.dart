import 'dart:async';

import 'package:flight_search/flight_stop.dart';
import 'package:flight_search/flight_stop_card.dart';
import 'package:flutter/material.dart';

class PriceTab extends StatefulWidget {
  final double height;
  final double width;
  final VoidCallback onPlaneSizeAnimated;

  const PriceTab({Key key, this.onPlaneSizeAnimated, this.height, this.width})
      : super(key: key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {
  AnimationController _initialPlainAnimationController;
  Animation<double> _planeSizeAnimation;
  AnimationController _planeTravelAnimationController;
  Animation<double> _planeTravelAnimation;
  AnimationController _dotsAnimationController;
  final double _startPaddingBottom = 16.0;
  final double _endPaddingTop = 16.0;
  final double _flightStopHeight = 80.0;
  final List<FlightStop> _flightStops = [
    FlightStop("JFK", "ORY", "JUN 05", "6h 25m", "\$851", "9:26 am - 3:43 pm"),
    FlightStop("MRG", "FTB", "JUN 20", "6h 25m", "\$532", "9:26 am - 3:43 pm"),
    FlightStop("ERT", "TVS", "JUN 20", "6h 25m", "\$718", "9:26 am - 3:43 pm"),
    FlightStop("KKR", "RTY", "JUN 20", "6h 25m", "\$663", "9:26 am - 3:43 pm"),
  ];
  final List<Animation<double>> stopPositions = [];

  double get _planeTopPadding =>
      _endPaddingTop +
          (1 - _planeTravelAnimation.value) *
              (widget.height - _endPaddingTop - _startPaddingBottom - 40.0);

  double get _planeIconSize => _planeSizeAnimation.value;

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
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _initialPlainAnimationController.isCompleted
              ? _buildTravelPlaneAnimation()
              : _buildInitialPlaneAnimation(),
        ]..addAll(
          _flightStops.map((stop) => _buildStopCard(stop)),
        )
          ..addAll(
            _flightStops.map(
                  (stop) => _buildDot(stop),
            ),
          ),
      ),
    );
  }

  Widget _buildTravelPlaneAnimation() {
    return AnimatedBuilder(
      animation: _planeTravelAnimation,
      builder: (context, child) {
        return Positioned(
          top: _planeTopPadding,
          child: Column(
            children: <Widget>[
              _buildPlaneIcon(),
              Container(
                width: 2.0,
                height: _flightStops.length * _flightStopHeight,
                color: Color.fromARGB(255, 200, 200, 200),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaneIcon() {
    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      size: _planeIconSize,
    );
  }

  Widget _buildInitialPlaneAnimation() {
    return Positioned(
      bottom: _startPaddingBottom,
      child: AnimatedBuilder(
        animation: _planeSizeAnimation,
        builder: (context, child) => _buildPlaneIcon(),
      ),
    );
  }

  void _initAnimations() {
    _initInitialAnimation();
    _initPlaneTravelAnimation();
    _initDotAnimation();
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
          new Future.delayed(Duration(milliseconds: 200),
                  () => _dotsAnimationController.forward());
        }
      });
    _planeSizeAnimation = Tween<double>(begin: 60.0, end: 36.0)
        .animate(_initialPlainAnimationController);
  }

  Widget _buildDot(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    Color color = index.isEven ? Colors.red : Colors.green;
    Animation<double> animation = stopPositions[index];
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) =>
          Positioned(
            top: animation.value,
            child: Container(
              height: 16.0,
              width: 16.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
    );
  }

  _initDotAnimation() {
    _dotsAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    final delayInterval = 0.2;
    final slideInterval = 0.4;
    double startingPaddingTop = widget.height + 16.0;
    double constMarginTop = 16.0 + _planeIconSize + 0.5 * _flightStopHeight;
    for (int i = 0; i < _flightStops.length; i++) {
      final start = delayInterval * i;
      final end = start + slideInterval;

      double endingPaddingTop = constMarginTop + i * _flightStopHeight;
      Animation<double> animation =
      new Tween(begin: startingPaddingTop, end: endingPaddingTop).animate(
        new CurvedAnimation(
          parent: _dotsAnimationController,
          curve: new Interval(start, end, curve: Curves.easeOut),
        ),
      );
      stopPositions.add(animation);
    }
  }

  Widget _buildStopCard(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    double topMargin = 8.0 + _planeIconSize + _flightStopHeight * (index + 0.5);
    bool isLeft = index.isOdd;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: topMargin),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isLeft ? Container() : Expanded(child: Container()),
            Expanded(child: FlightStopCard(flightStop: stop, isLeft: isLeft)),
            !isLeft ? Container() : Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

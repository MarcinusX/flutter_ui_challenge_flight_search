import 'dart:async';

import 'package:flight_search/fade_route.dart';
import 'package:flight_search/flight_stop.dart';
import 'package:flight_search/flight_stop_card.dart';
import 'package:flight_search/tickets_page.dart';
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
  AnimationController _planeSizeAnimationController;
  Animation<double> _planeSizeAnimation;
  AnimationController _planeTravelAnimationController;
  Animation<double> _planeTravelAnimation;
  AnimationController _dotsAnimationController;
  AnimationController _fabAnimationController;
  Animation<double> _fabAnimation;
  final double _startPaddingBottom = 16.0;
  final double _endPaddingTop = 16.0;
  final List<FlightStop> _flightStops = [
    FlightStop("JFK", "ORY", "JUN 05", "6h 25m", "\$851", "9:26 am - 3:43 pm"),
    FlightStop("MRG", "FTB", "JUN 20", "6h 25m", "\$532", "9:26 am - 3:43 pm"),
    FlightStop("ERT", "TVS", "JUN 20", "6h 25m", "\$718", "9:26 am - 3:43 pm"),
    FlightStop("KKR", "RTY", "JUN 20", "6h 25m", "\$663", "9:26 am - 3:43 pm"),
  ];
  final List<Animation<double>> stopPositions = [];
  final List<GlobalKey<FlightStopCardState>> _stopKeys = [];

  double get _planeTopPadding =>
      _endPaddingTop +
          (1 - _planeTravelAnimation.value) *
              (widget.height - _endPaddingTop - _startPaddingBottom - 40.0);

  double get _planeIconSize => _planeSizeAnimation.value;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _flightStops
        .forEach((stop) => _stopKeys.add(new GlobalKey<FlightStopCardState>()));
    _planeSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _planeSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[_buildTravelPlaneAnimation()]
          ..addAll(_flightStops.map((stop) => _buildStopCard(stop)))..addAll(
              _flightStops.map((stop) => _buildDot(stop)))
          ..add(_buildFab()),
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
                height: _flightStops.length * 0.8 * FlightStopCard.height,
                color: Color.fromARGB(255, 200, 200, 200),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaneIcon() {
    return AnimatedBuilder(
      animation: _planeSizeAnimation,
      builder: (context, child) =>
          Icon(
            Icons.airplanemode_active,
            color: Colors.red,
            size: _planeIconSize,
          ),
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
    _initDotAnimationController();
    _initDotAnimations();
    _initFabAnimationController();
  }

  void _initPlaneTravelAnimation() {
    _planeTravelAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _planeTravelAnimation = CurvedAnimation(
      parent: _planeTravelAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _initInitialAnimation() {
    _planeSizeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 340),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onPlaneSizeAnimated();
          Future.delayed(Duration(milliseconds: 500),
                  () => _planeTravelAnimationController.forward());
          Future.delayed(Duration(milliseconds: 700),
                  () => _dotsAnimationController.forward());
        }
      });
    _planeSizeAnimation = Tween<double>(begin: 60.0, end: 36.0).animate(
        CurvedAnimation(
            parent: _planeSizeAnimationController, curve: Curves.easeOut));
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

  void _initDotAnimations() {
    //what part of whole animation takes one dot travel
    final double slideDurationInterval = 0.4;
    //what are delays between dot animations
    final double slideDelayInterval = 0.2;
    //at the bottom of the screen
    double startingMarginTop = widget.height + 16.0;
    //minimal margin from the top (where first dot will be placed)
    double minMarginTop =
        16.0 + _planeIconSize + 0.5 * 0.8 * FlightStopCard.height;

    for (int i = 0; i < _flightStops.length; i++) {
      final start = slideDelayInterval * i;
      final end = start + slideDurationInterval;

      double finalMarginTop = minMarginTop + i * 0.8 * FlightStopCard.height;
      Animation<double> animation =
      new Tween(begin: startingMarginTop, end: finalMarginTop).animate(
        new CurvedAnimation(
          parent: _dotsAnimationController,
          curve: new Interval(start, end, curve: Curves.easeOut),
        ),
      );
      stopPositions.add(animation);
    }
  }

  void _initDotAnimationController() {
    _dotsAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _dotsAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animateFlightStopCards().then((_) => _animateFab());
      }
    });
  }

  Future _animateFlightStopCards() async {
    return Future.forEach(_stopKeys, (GlobalKey<FlightStopCardState> stopKey) {
      return new Future.delayed(Duration(milliseconds: 250), () {
        stopKey.currentState.runEntryAnimation();
      });
    });
  }

  Widget _buildStopCard(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    double topMargin =
        8.0 + _planeIconSize + 0.8 * FlightStopCard.height * (index + 0.5);
    Key key = _stopKeys[index];
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
            Expanded(
                child: FlightStopCard(
                  flightStop: stop,
                  isLeft: isLeft,
                  key: key,
                )),
            !isLeft ? Container() : Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildFab() {
    return Positioned(
      bottom: 16.0,
      child: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          onPressed: () =>
              Navigator
                  .of(context)
                  .push(new FadeRoute(builder: (context) => TicketsPage())),
          child: Icon(Icons.check),
        ),
      ),
    );
  }

  void _initFabAnimationController() {
    _fabAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _fabAnimation = new CurvedAnimation(
        parent: _fabAnimationController, curve: Curves.easeOut);
  }

  _animateFab() {
    _fabAnimationController.forward();
  }
}

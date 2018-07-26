import 'dart:async';

import 'package:flight_search/flight_stop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FlightStopCard extends StatefulWidget {
  final FlightStop flightStop;
  final bool isLeft;
  static const double height = 80.0;
  static const double width = 140.0;

  const FlightStopCard(
      {Key key, @required this.flightStop, @required this.isLeft})
      : super(key: key);

  @override
  FlightStopCardState createState() => FlightStopCardState();
}

class FlightStopCardState extends State<FlightStopCard>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> cardSizeAnimation;
  Animation<double> durationPositionAnimation;
  Animation<double> airportsPositionAnimation;
  Animation<double> datePositionAnimation;
  Animation<double> pricePositionAnimation;
  Animation<double> fromToPositionAnimation;
  Animation<double> lineAnimation;
  Orientation orientation;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 600));
    cardSizeAnimation = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.0, 0.9, curve: new ElasticOutCurve(0.8)));
    durationPositionAnimation = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.05, 0.95, curve: new ElasticOutCurve(0.95)));
    airportsPositionAnimation = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.1, 1.0, curve: new ElasticOutCurve(0.95)));
    datePositionAnimation = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.1, 0.8, curve: new ElasticOutCurve(0.95)));
    pricePositionAnimation = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.0, 0.9, curve: new ElasticOutCurve(0.95)));
    fromToPositionAnimation = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.1, 0.95, curve: new ElasticOutCurve(0.95)));
    lineAnimation = new CurvedAnimation(
        parent: animationController,
        curve: new Interval(0.0, 0.2, curve: Curves.linear));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  runEntryAnimation() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery
        .of(context)
        .orientation != orientation) {
      new Future.delayed(
        Duration(milliseconds: 10),
            () =>
            setState(() =>
            orientation = MediaQuery
                .of(context)
                .orientation),
      );
    }
    return Container(
      height: FlightStopCard.height,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return new Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              buildLine(),
              buildCard(),
              buildDurationText(),
              buildAirportNamesText(),
              buildDateText(),
              buildPriceText(),
              buildFromToTimeText(),
            ],
          );
        },
      ),
    );
  }

  double get maxWidth {
    RenderBox renderBox = context.findRenderObject();
    BoxConstraints constraints = renderBox?.constraints;
    double maxWidth = constraints?.maxWidth ?? 0.0;
    return maxWidth;
  }

  Positioned buildDurationText() {
    return Positioned(
      top: getMarginTop(durationPositionAnimation.value),
      right: getMarginRight(durationPositionAnimation.value),
      child: Text(
        widget.flightStop.duration,
        style: new TextStyle(
          fontSize: 10.0 * durationPositionAnimation.value,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned buildAirportNamesText() {
    return Positioned(
      top: getMarginTop(airportsPositionAnimation.value),
      left: getMarginLeft(airportsPositionAnimation.value),
      child: Text(
        "${widget.flightStop.from} \u00B7 ${widget.flightStop.to}",
        style: new TextStyle(
          fontSize: 14.0 * airportsPositionAnimation.value,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned buildDateText() {
    return Positioned(
      left: getMarginLeft(datePositionAnimation.value),
      child: Text(
        "${widget.flightStop.date}",
        style: new TextStyle(
          fontSize: 14.0 * datePositionAnimation.value,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned buildPriceText() {
    return Positioned(
      right: getMarginRight(pricePositionAnimation.value),
      child: Text(
        "${widget.flightStop.price}",
        style: new TextStyle(
            fontSize: 16.0 * pricePositionAnimation.value,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Positioned buildFromToTimeText() {
    return Positioned(
      left: getMarginLeft(fromToPositionAnimation.value),
      bottom: getMarginBottom(fromToPositionAnimation.value),
      child: Text(
        "${widget.flightStop.fromToTime}",
        style: new TextStyle(
            fontSize: 12.0 * fromToPositionAnimation.value,
            color: Colors.grey,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildLine() {
    double maxLength = maxWidth - FlightStopCard.width;
    return Align(
        alignment: widget.isLeft ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 2.0,
          width: lineAnimation.value * maxLength,
          color: Colors.grey,
        ));
  }

  Positioned buildCard() {
    double constOuterMargin = 8.0;
    double outerMargin =
        constOuterMargin + (1 - cardSizeAnimation.value) * maxWidth;
    return Positioned(
      right: widget.isLeft ? null : outerMargin,
      left: widget.isLeft ? outerMargin : null,
      child: Transform.scale(
        scale: cardSizeAnimation.value,
        child: Container(
          width: 140.0,
          height: 80.0,
          child: new Card(
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  double getMarginBottom(double animationValue) {
    double startBottomMargin = FlightStopCard.height * 0.5;
    double minBottomMargin = 8.0;
    double bottomMargin =
        minBottomMargin + (1 - animationValue) * startBottomMargin;
    return bottomMargin;
  }

  double getMarginTop(double animationValue) {
    double constMarginTop = 8.0;
    double marginTop =
        constMarginTop + (1 - animationValue) * FlightStopCard.height * 0.5;
    return marginTop;
  }

  double getMarginLeft(double animationValue) {
    if (widget.isLeft) {
      double minHorizontalMargin = 16.0;
      double maxHorizontalMargin = maxWidth - minHorizontalMargin;
      double horizontalMargin =
          minHorizontalMargin + (1 - animationValue) * maxHorizontalMargin;
      return horizontalMargin;
    } else {
      double maxHorizontalMargin = maxWidth - FlightStopCard.width;
      double horizontalMargin = animationValue * maxHorizontalMargin;
      return horizontalMargin;
    }
  }

  double getMarginRight(double animationValue) {
    if (widget.isLeft) {
      double maxHorizontalMargin = maxWidth - FlightStopCard.width;
      double horizontalMargin = animationValue * maxHorizontalMargin;
      return horizontalMargin;
    } else {
      double minHorizontalMargin = 16.0;
      double maxHorizontalMargin = maxWidth - minHorizontalMargin;
      double horizontalMargin =
          minHorizontalMargin + (1 - animationValue) * maxHorizontalMargin;
      return horizontalMargin;
    }
  }
}

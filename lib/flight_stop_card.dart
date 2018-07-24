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
  AnimationController cardController;
  Animation<double> cardSizeAnimation;
  Animation<double> durationPositionAnimation;
  Animation<double> lineAnimation;

  @override
  void initState() {
    super.initState();
    cardController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    cardSizeAnimation = new CurvedAnimation(
        parent: cardController, curve: new ElasticOutCurve(0.95));
    durationPositionAnimation = new CurvedAnimation(
        parent: cardController,
        curve: new Interval(0.0, 0.8, curve: new ElasticOutCurve(0.95)));
    lineAnimation = new CurvedAnimation(parent: cardController,
        curve: new Interval(0.0, 0.2, curve: Curves.linear));
  }

  @override
  void dispose() {
    cardController.dispose();
    super.dispose();
  }

  runEntryAnimation() {
    cardController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: 1 * 140.0,
      height: 1 * 80.0,
      child: new Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.flightStop.from + " * " + widget.flightStop.to),
                Text(widget.flightStop.duration)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.flightStop.date),
                Text(widget.flightStop.price)
              ],
            ),
            Text(widget.flightStop.fromToTime)
          ],
        ),
      ),
    );

    return Container(
      height: FlightStopCard.height,
      child: AnimatedBuilder(
        animation: cardController,
        builder: (context, child) {
          BoxConstraints cons = context
              .findRenderObject()
              ?.constraints;
          double maxHeight = FlightStopCard.height;
          double maxWidth = cons?.maxWidth ?? 0.0;
          print(cons);
          return new Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              buildLine(maxWidth),
              buildCard(maxWidth),
              buildDurationText(maxWidth)
            ],
          );
        },
      ),
    );
    List<Widget> children = <Widget>[
      Expanded(
        child: new Container(
          height: 2.0,
          color: Colors.grey,
        ),
      ),
      card
    ];

    if (widget.isLeft) {
      children = children.reversed.toList();
    }

    return AnimatedBuilder(
      animation: cardSizeAnimation,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Positioned buildDurationText(double maxWidth) {
    double constMarginTop = 6.0;
    double constMarginRight = 16.0;
    double marginTop = constMarginTop +
        (1 - durationPositionAnimation.value) * FlightStopCard.height * 0.5;
    double marginRight = constMarginRight +
        (1 - durationPositionAnimation.value) * maxWidth;
    double fontSize = 16.0 * durationPositionAnimation.value;
    return Positioned(
      top: marginTop,
      right: marginRight,
      child: Text(
        widget.flightStop.duration, style: new TextStyle(fontSize: fontSize),),
    );
  }

  Widget buildLine(double maxWidth) {
    double maxLength = maxWidth - FlightStopCard.width;
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 2.0,
          width: lineAnimation.value * maxLength,
          color: Colors.grey,
        )
    );
  }

  Positioned buildCard(double maxWidth) {
    double constMarginRight = 8.0;
    double marginRight = constMarginRight +
        (1 - cardSizeAnimation.value) * maxWidth;
    return Positioned(
      right: marginRight,
      child: Transform.scale(
        scale: cardSizeAnimation.value,
        child: Container(
          width: 140.0,
          height: 80.0,
          child: new Card(),
        ),
      ),
    );
  }
}

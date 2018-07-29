import 'package:flight_search/price_tab/flight_stop.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: FlightStopCard.height,
      child: new Stack(
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
      top: getMarginTop(),
      right: getMarginRight(),
      child: Text(
        widget.flightStop.duration,
        style: new TextStyle(
          fontSize: 10.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned buildAirportNamesText() {
    return Positioned(
      top: getMarginTop(),
      left: getMarginLeft(),
      child: Text(
        "${widget.flightStop.from} \u00B7 ${widget.flightStop.to}",
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned buildDateText() {
    return Positioned(
      left: getMarginLeft(),
      child: Text(
        "${widget.flightStop.date}",
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned buildPriceText() {
    return Positioned(
      right: getMarginRight(),
      child: Text(
        "${widget.flightStop.price}",
        style: new TextStyle(
            fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Positioned buildFromToTimeText() {
    return Positioned(
      left: getMarginLeft(),
      bottom: getMarginBottom(),
      child: Text(
        "${widget.flightStop.fromToTime}",
        style: new TextStyle(
            fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildLine() {
    double maxLength = maxWidth - FlightStopCard.width;
    return Align(
        alignment: widget.isLeft ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 2.0,
          width: maxLength,
          color: Color.fromARGB(255, 200, 200, 200),
        ));
  }

  Positioned buildCard() {
    double outerMargin = 8.0;
    return Positioned(
      right: widget.isLeft ? null : outerMargin,
      left: widget.isLeft ? outerMargin : null,
      child: Container(
        width: 140.0,
        height: 80.0,
        child: new Card(
          color: Colors.grey.shade100,
        ),
      ),
    );
  }

  double getMarginBottom() {
    double minBottomMargin = 8.0;
    return minBottomMargin;
  }

  double getMarginTop() {
    double minMarginTop = 8.0;
    return minMarginTop;
  }

  double getMarginLeft() {
    return getMarginHorizontal(true);
  }

  double getMarginRight() {
    return getMarginHorizontal(false);
  }

  double getMarginHorizontal(bool isTextLeft) {
    if (isTextLeft == widget.isLeft) {
      double minHorizontalMargin = 16.0;
      return minHorizontalMargin;
    } else {
      double maxHorizontalMargin = maxWidth - FlightStopCard.width;
      return maxHorizontalMargin;
    }
  }
}

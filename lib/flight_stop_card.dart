import 'package:flight_search/flight_stop.dart';
import 'package:flutter/material.dart';

class FlightStopCard extends StatefulWidget {
  final FlightStop flightStop;
  final bool isLeft;
  static const double height = 80.0;

  const FlightStopCard(
      {Key key, @required this.flightStop, @required this.isLeft})
      : super(key: key);

  @override
  _FlightStopCardState createState() => _FlightStopCardState();
}

class _FlightStopCardState extends State<FlightStopCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      Expanded(
        child: new Container(
          height: 2.0,
          color: Colors.grey,
        ),
      ),
      Container(
        width: 140.0,
        height: 80.0,
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
      )
    ];

    if (widget.isLeft) {
      children = children.reversed.toList();
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}

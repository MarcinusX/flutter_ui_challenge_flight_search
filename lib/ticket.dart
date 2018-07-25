import 'dart:math' as math;

import 'package:flight_search/flight_stop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Ticket extends StatelessWidget {
  final TicketFlightStop stop;

  const Ticket({Key key, this.stop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle airportNameStyle =
        new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);
    TextStyle airportShortNameStyle =
        new TextStyle(fontSize: 36.0, fontWeight: FontWeight.w200);
    TextStyle flightNumberStyle =
        new TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500);
    return Material(
      elevation: 2.0,
      shadowColor: Color(0x30E5E5E5),
      color: Colors.transparent,
      child: ClipPath(
        clipper: TicketClipper(),
        child: Card(
          elevation: 0.0,
          margin: const EdgeInsets.all(2.0),
          child: Container(
            height: 104.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(stop.from, style: airportNameStyle),
                        ),
                        Text(
                          stop.fromShort,
                          style: airportShortNameStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.airplanemode_active,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      stop.flightNumber,
                      style: flightNumberStyle,
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(stop.to, style: airportNameStyle),
                        ),
                        Text(
                          stop.toShort,
                          style: airportShortNameStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addArc(
        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: 12.0),
        -math.pi / 2,
        math.pi);
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: 12.0));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

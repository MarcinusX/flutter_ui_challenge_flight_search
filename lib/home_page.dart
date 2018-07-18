import 'package:flight_search/details_card.dart';
import 'package:flight_search/rounded_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, const Color(0xFFE64C85)],
              ),
            ),
            height: 240.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text("AirAsia"),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: new Column(
                children: <Widget>[
                  _buttonsRow(),
                  Expanded(child: DetailsCard()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new RoundedButton(
            text: "ONE WAY",
          ),
          new RoundedButton(
            text: "ROUND",
          ),
          new RoundedButton(
            selected: true,
            text: "MULTICITY",
          ),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRoute {

  final Widget child;

  FadeRoute(this.child);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;


  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

}

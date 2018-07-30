import 'package:flight_search/typable_text.dart';
import 'package:flutter/material.dart';

class MulticityInput extends StatefulWidget {
  @override
  MulticityInputState createState() {
    return new MulticityInputState();
  }
}

class MulticityInputState extends State<MulticityInput>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
  Animation fromAnimation;
  Animation toAnimation1;
  Animation toAnimation2;
  Animation passengersAnimation;
  Animation departureAnimation;
  Animation arrivalAnimation;

  @override
  void initState() {
    super.initState();
    textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    fromAnimation = new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(0.0, 0.2, curve: Curves.linear));
    toAnimation1 = new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(0.15, 0.35, curve: Curves.linear));
    toAnimation2 = new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(0.3, 0.5, curve: Curves.linear));
    passengersAnimation = new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(0.45, 0.65, curve: Curves.linear));
    departureAnimation = new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(0.6, 0.8, curve: Curves.linear));
    arrivalAnimation = new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(0.75, 0.95, curve: Curves.linear));
  }

  @override
  void dispose() {
    textInputAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TypeableTextFormField(
                finalText: "Kochfurt",
                animation: fromAnimation,
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_takeoff, color: Colors.red),
                  labelText: "From",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TypeableTextFormField(
                animation: toAnimation1,
                finalText: "Lake Xanderland",
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_land, color: Colors.red),
                  labelText: "To",
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TypeableTextFormField(
                      animation: toAnimation2,
                      finalText: "South Darian",
                      decoration: InputDecoration(
                        icon: Icon(Icons.flight_land, color: Colors.red),
                        labelText: "To",
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 64.0,
                  alignment: Alignment.center,
                  child: IconButton(
                      onPressed: () => textInputAnimationController.forward(),
                      icon: Icon(Icons.add_circle_outline, color: Colors.grey)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TypeableTextFormField(
                animation: passengersAnimation,
                finalText: "4",
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "Passengers",
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range, color: Colors.red),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TypeableTextFormField(
                      animation: departureAnimation,
                      finalText: "29 June 2017",
                      decoration: InputDecoration(labelText: "Departure"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TypeableTextFormField(
                      animation: arrivalAnimation,
                      finalText: "29 July 2017",
                      decoration: InputDecoration(labelText: "Arrival"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

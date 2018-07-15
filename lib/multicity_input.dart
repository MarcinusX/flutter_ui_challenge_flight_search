import 'package:flutter/material.dart';

class MulticityInput extends StatefulWidget {
  @override
  _MulticityInputState createState() => _MulticityInputState();
}

class _MulticityInputState extends State<MulticityInput> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.flight_takeoff,
                      color: Colors.red,
                    ),
                    labelText: "From",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.flight_land,
                      color: Colors.red,
                    ),
                    labelText: "To",
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.flight_land,
                            color: Colors.red,
                          ),
                          labelText: "To",
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 64.0,
                      alignment: Alignment.center,
                      child: Icon(Icons.add_circle_outline))
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                    labelText: "Passengers",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.date_range,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Departure",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Arrival",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flight_search/multicity_input.dart';
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
            color: Colors.red,
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
                  Expanded(child: _card()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _card() {
    return new Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Column(
              children: <Widget>[
                _tabBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: new ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: viewportConstraints.maxHeight - 48.0,
                      ),
                      child: new IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              MulticityInput(),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                  onPressed: () {},
                                  child: Icon(Icons.timeline),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        length: 3,
      ),
    );
  }

  Stack _tabBar() {
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          top: null,
          child: new Container(
            height: 2.0,
            color: new Color(0xFFEEEEEE),
          ),
        ),
        new TabBar(
          tabs: [
            Tab(text: "Flight"),
            Tab(text: "Train"),
            Tab(text: "Bus"),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ],
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

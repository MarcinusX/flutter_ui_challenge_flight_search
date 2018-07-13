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
            height: 200.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text("AirAsia"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new RoundedButton(
                        text: "ONE WAY",
                      ),
                      new RoundedButton(
                        text: "ROUND",
                      ),
                      new RoundedButton(
                        text: "MULTICITY",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;

  const RoundedButton({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new InkWell(
          onTap: () => print('hello'),
          child: new Container(
            //width: 100.0,
            height: 40.0,
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white, width: 1.0),
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: new Center(
              child: new Text(
                text,
                style: new TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

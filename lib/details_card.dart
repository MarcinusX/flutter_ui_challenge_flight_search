import 'package:flight_search/multicity_input.dart';
import 'package:flight_search/price_tab.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatefulWidget {
  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  bool showFirstOptionInAppBar = true;
  bool showMultiCityInput = true;

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Column(
              children: <Widget>[
                _tabBar(showFirstOption: showFirstOptionInAppBar),
                Expanded(
                  child: SingleChildScrollView(
                    child: new ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: viewportConstraints.maxHeight - 48.0,
                      ),
                      child: new IntrinsicHeight(
                        child: showMultiCityInput
                            ? _buildMulticityTab()
                            : PriceTab(
                          onPlaneSizeAnimated: () =>
                              setState(
                                      () => showFirstOptionInAppBar = false),
                        ),
                      ),
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

  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
        MulticityInput(),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () => setState(() => showMultiCityInput = false),
            child: Icon(Icons.timeline),
          ),
        ),
      ],
    );
  }

  Stack _tabBar({bool showFirstOption}) {
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
            Tab(text: showFirstOption ? "Flight" : "Price"),
            Tab(text: showFirstOption ? "Train" : "Duration"),
            Tab(text: showFirstOption ? "Bus" : "Stops"),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ],
    );
  }
}

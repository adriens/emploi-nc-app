import 'package:EmploiNC/Widget_ListOffers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:  Colors.blue[900],
            flexibleSpace: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children : [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Expanded(child: Icon(Icons.insert_chart)),
                            Expanded(child: new Text('Stats'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ),
          body: TabBarView(
            children: [
              new Text('Stats'),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:EmploiNC/Widget/ListOffers.dart';
import 'package:EmploiNC/Widget/Stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[900],
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blue[900],
        brightness: Brightness.dark,
      ),
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
              new StatsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:EmploiNC/Widget/ListOffers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:EmploiNC/Widget/GridView.dart';

class DefaultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[900],
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blue[900],
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 2,
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
                            Expanded(child: new Text('1'))

                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Expanded(child: new Text('2'))
                          ],
                        ),
                      )
                    ],
                  ),
                ]
            ),
          ),
          body: TabBarView(
            children: [
              Text('1'),
              Text('2')
            ],
          ),
        ),
      ),
    );
  }
}
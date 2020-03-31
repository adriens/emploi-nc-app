import 'package:EmploiNC/Widget_ListOffers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
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
                            Expanded(child: Icon(Icons.info))
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Expanded( child: Icon(Icons.people_outline) )
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Expanded( child: Icon(Icons.share) )
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
              new Text('A Propos'),
              new Text('Collaborateurs'),
              new Text('Social')
            ],
          ),
        ),
      ),
    );
  }
}
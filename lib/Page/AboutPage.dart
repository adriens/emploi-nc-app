import 'file:///C:/Users/JAVAE/Documents/emploi-nc-app/lib/Widget/ListOffers.dart';
import 'package:EmploiNC/Widget/About.dart';
import 'package:EmploiNC/Widget/Social.dart';
import 'package:EmploiNC/Widget/Collaborateurs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
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
              AboutWidget(),
              CollaborateursWidget(),
              SocialWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
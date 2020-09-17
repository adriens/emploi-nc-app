import 'package:EmploiNC/src/Variable/Variable.dart';
import 'package:EmploiNC/src/Widget/About.dart';
import 'package:EmploiNC/src/Widget/Social.dart';
import 'package:EmploiNC/src/Widget/Collaborateurs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      brightness: themeisDark ? themebrightnessDark: themebrightnessLight,
      primaryColor: primaryColor,
    ),
      darkTheme: ThemeData(
        primaryColor: primaryColor,
        brightness: themeisDark ? themebrightnessDark: themebrightnessLight,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:  primaryColor,
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
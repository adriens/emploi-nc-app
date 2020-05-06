import 'package:EmploiNC/Variable/Variable.dart';
import 'package:EmploiNC/Widget/AllOffers.dart';
import 'package:EmploiNC/Widget/ListOffers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:EmploiNC/Widget/GridView.dart';
import 'package:flutter_offline/flutter_offline.dart';

class HomePage extends StatelessWidget {
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
                            Expanded(child: Icon(Icons.history)),
                            Expanded(child: new Text('Récentes'))
                          ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Icon(Icons.list)),
                          Expanded(child: new Text('Toutes'))
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
              OfflineBuilder(
                connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                    ) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  return new Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child:  connected ? GridViewWidget() : Text("Hors Ligne"),
                      ),
                    ],
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new GridViewWidget(),
                  ],
                ),
              ),
              OfflineBuilder(
                connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                    ) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  return new Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child:  connected ? AllOffers() : Text("Hors Ligne"),
                      ),
                    ],
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new AllOffers(),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
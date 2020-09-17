import 'package:EmploiNC/src/Variable/Variable.dart';
import 'package:EmploiNC/src/Widget/Stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class StatsPage extends StatelessWidget {
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
          body: OfflineBuilder(
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
                    child:  connected ? StatsWidget() : Text("Hors Ligne"),
                  ),
                ],
              );
            },
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new StatsWidget(),
            ],
          ),
          ),
        ),
      )
    );
  }
}
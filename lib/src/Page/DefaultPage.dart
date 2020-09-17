import 'package:EmploiNC/src/Variable/Variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
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
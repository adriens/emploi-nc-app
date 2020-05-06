import 'package:EmploiNC/Variable/Variable.dart';
import 'package:EmploiNC/Widget/AllOffers.dart';
import 'package:EmploiNC/Widget/Parameter.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParameterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: themeisDark ? themebrightnessDark: themebrightnessLight,
            primaryColor: Colors.blue[900],
          ),
          darkTheme: ThemeData(
            primaryColor: Colors.blue[900],
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
                                Expanded(child: Icon(Icons.settings)),
                                Expanded(child: Text("Paramètres"))
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
                  Parameter(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

}
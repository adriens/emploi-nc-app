import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Page/AboutPage.dart';
import 'Page/HomePage.dart';
import 'Page/ParameterPage.dart';
import 'Page/SearchPage.dart';
import 'Page/StatsPage.dart';
import 'Widget/PlaceHolder.dart';


class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget( HomePage() ),
    //PlaceholderWidget( DefaultPage() ),
    PlaceholderWidget( SearchPage() ),
    PlaceholderWidget( StatsPage() ),
    PlaceholderWidget( AboutPage() ),
    PlaceholderWidget( ParameterPage() ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new// this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            backgroundColor:  Colors.blue[900],
            title: new Text('Offres'),
          ),
          /*BottomNavigationBarItem(
            icon: new Icon(Icons.group_work),
            backgroundColor:  Colors.blue[900],
            title: new Text('Libre'),
          ),*/
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            backgroundColor:  Colors.blue[900],
            title: new Text('Recherche'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.equalizer),
              backgroundColor:  Colors.blue[900],
              title: Text('Stats')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              backgroundColor:  Colors.blue[900],
              title: Text('A Propos')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor:  Colors.blue[900],
              title: Text('Paramètres')
          )
        ],
      ),
    );
  }
}
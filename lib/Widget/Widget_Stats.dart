import 'package:EmploiNC/Model/Stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import '../Service/StatsService.dart';

class StatsWidget extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Stats"),
    );
  }
  StatsWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _StatsWidget createState() => _StatsWidget();

}

class _StatsWidget extends State<StatsWidget> with SingleTickerProviderStateMixin {
  Animation<int> _animationTotal;
  Animation<int> _animationEmployeurs;
  Animation<int> _animationCurrent;

  AnimationController _animationController;

  // List of Items
  Future<Stats> stats;

  _refresh() {
    stats = StatsService.getStats();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    _animationTotal = IntTween(begin: 0, end: 4000).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationCurrent = IntTween(begin: 0, end: 100).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationEmployeurs = IntTween(begin: 0, end: 800).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }



  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  static const String _title = 'Stats';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: stats,
      builder: (context, AsyncSnapshot<Stats> snapshot) {
        if (snapshot.hasData) {
          return buildStatsAfter(snapshot);
        } else if (snapshot.hasError) {
          return Text("WHAT :" + snapshot.error.toString());
        }
        return buildStatsBefore();
      },
    );

  }


  Widget buildStatsAfter(AsyncSnapshot<Stats> snapshot) {
       return new Scaffold(
          body: new Center(
              child: GridView(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0),
                  children:
                  <Widget>[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          footer: Text(
                            "Offres Publiées",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          child: Icon(Icons.library_add,
                              size: 80.0, color: Colors.blue),
                        ),
                      ),
                      margin: EdgeInsets.all(1.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              snapshot.data.nbOffresPublieesTotales,
                              style: TextStyle(
                                fontSize: 52.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      margin: EdgeInsets.all(1.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          footer: Text(
                            "Offres en Cours",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          child: Icon(Icons.library_books,
                              size: 80.0, color: Colors.blue),
                        ),
                      ),
                      margin: EdgeInsets.all(1.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              snapshot.data.nbOffresPublieesEnCours,
                              style: TextStyle(
                                fontSize: 52.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      margin: EdgeInsets.all(1.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          footer: Text(
                            "Nb d'Employeurs",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          child: Icon(Icons.work,
                              size: 80.0, color: Colors.blue),
                        ),
                      ),
                      margin: EdgeInsets.all(1.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              snapshot.data.nbEmployeursAvecOffresPubliees,
                              style: TextStyle(
                                fontSize: 52.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      margin: EdgeInsets.all(1.0),
                    ),
                  ]
              )
          )
      );
  }

  Widget buildStatsBefore() {

    Widget _buildItemForColor(Color c) =>
        DecoratedBox(decoration: BoxDecoration(color: c));

    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return GridView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0),
            children:
              <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: GridTile(
                      footer: Text(
                        "Offres Publiées",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      child: Icon(Icons.library_add,
                          size: 80.0, color: Colors.blue),
                    ),
                  ),
                  margin: EdgeInsets.all(1.0),
              ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: GridTile(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          _animationTotal.value.toString(),
                          style: TextStyle(
                            fontSize: 52.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(1.0),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: GridTile(
                      footer: Text(
                        "Offres en Cours",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      child: Icon(Icons.library_books,
                          size: 80.0, color: Colors.blue),
                    ),
                  ),
                  margin: EdgeInsets.all(1.0),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: GridTile(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          _animationCurrent.value.toString(),
                          style: TextStyle(
                            fontSize: 52.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(1.0),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: GridTile(
                      footer: Text(
                        "Nb d'Employeurs",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      child: Icon(Icons.work,
                          size: 80.0, color: Colors.blue),
                    ),
                  ),
                  margin: EdgeInsets.all(1.0),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: GridTile(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          _animationEmployeurs.value.toString(),
                          style: TextStyle(
                            fontSize: 52.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(1.0),
                ),
            ]
          );
        });

  }

  Column _buildStatsColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 52.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }


}
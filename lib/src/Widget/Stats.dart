import 'package:EmploiNC/src/Model/Stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:EmploiNC/src/Service/StatsService.dart';

class StatsWidget extends StatefulWidget {

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: stats,
      builder: (context, AsyncSnapshot<Stats> snapshot) {
        if (snapshot.hasData) {
          return buildStatsAfter(snapshot);
        } else if (snapshot.hasError) {
          return Text("Erreur :");
        }
        return buildStatsBefore();
      },
    );
  }

  Widget buildStatsAfter(AsyncSnapshot<Stats> snapshot) {

      var size = MediaQuery.of(context).size;
      final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
      final double itemWidth = size.width / 2;

       return new Scaffold(
          body: new Center(
              child: GridView(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisCount: 2
                  ),
                  children:
                  <Widget>[
                    Container(height:100,
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;

    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return GridView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: (itemWidth / itemHeight),
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


}
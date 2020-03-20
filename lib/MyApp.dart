import 'package:EmploiNC/Emploi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'EmploiService.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue[900],
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blue[900],
        brightness: Brightness.dark,
      ),
      home:  Dashboard(),
    );
  }
}

// Notez que toute variable, définie au niveau de cette première partie du Widget, ne changera normalement PAS au cours de sa durée de vie.
class Dashboard extends StatefulWidget {

  Dashboard({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _Dashboard createState() => _Dashboard();

}

class _Dashboard extends State<Dashboard> {

  // List of Items
  Future<List<Emploi>> emplois;

  _refresh() {
    emplois = EmploiService.getLatestEmplois();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  static const String _title = 'Emploi NC';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text(_title),
        ),
        body: FutureBuilder<List<Emploi>>(
          future: emplois,
          builder: (BuildContext context, AsyncSnapshot<List<Emploi>> snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder:(BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                        child: InkWell(
                          onTap: () => launch(snapshot.data[index].url),
                          child: Row(
                            children: <Widget>[
                            Container(
                              height: 100.0,
                              width: 80.0,
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: new Image.memory(snapshot.data[index].decodeLogo(),fit: BoxFit.contain  ),
                            ),
                            Container(
                              height: 100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(
                                      width: 260,
                                      child: Text(snapshot.data[index].titreOffre,style:
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ), overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                      ),
                                      child: Text(snapshot.data[index].typeContrat,textAlign: TextAlign.center,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                              child: Text(snapshot.data[index].communeEmploi),
                                            ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(100, 3, 0, 3),
                                            child: Text(snapshot.data[index].aPourvoirLe),
                                          ),
                                      ]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                        )
                    )
                  );
                }
              );
          }
        ),
    );
  }
}



import 'package:EmploiNC/Emploi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EmploiService.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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


              return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) { return Divider(); },
                  itemBuilder:(BuildContext context, int index) {
                    return ListTile(
                        title: Text(snapshot.data[index].titreOffre)
                    );
                  }
              );
          }
        ),
    );
  }
}



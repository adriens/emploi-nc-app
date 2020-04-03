import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/Emploi.dart';
import '../Service/EmploiService.dart';

class ListOffers extends StatefulWidget {

  ListOffers({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _ListOffers createState() => _ListOffers();

}

class _ListOffers extends State<ListOffers> {

  // List of Items
  Future<List<Emploi>> emplois;

  _refresh() {
    emplois = EmploiService.getLatestEmplois("10");
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
      body: FutureBuilder<List<Emploi>>(
          future: emplois,
          builder: (BuildContext context, AsyncSnapshot<List<Emploi>> snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting)
              return ListView.builder(
                  itemCount: 10,
                  // Important code

                  itemBuilder: (context, index) => Shimmer.fromColors(
                    child: Card (
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                              ),
                            ],
                          ),
                        )
                    ),
                    baseColor: Colors.black12,
                    highlightColor: Colors.black26,
                  ));

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
                                          width: 260,
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                new Text(snapshot.data[index].communeEmploi),
                                                new Text(snapshot.data[index].aPourvoirLe)
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
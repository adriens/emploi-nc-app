import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Service/EmploiService.dart';

class GridViewWidget extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("GridView"),
    );
  }
  GridViewWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _GridViewWidget createState() => _GridViewWidget();

}

class _GridViewWidget extends State<GridViewWidget> {

// List of Items
  Future<List<Emploi>> emplois;

  _refresh() {
    emplois = EmploiService.getLatestEmplois("4");
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  static const String _title = 'GridView';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: emplois,
      builder: (context, AsyncSnapshot<List<Emploi>> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(AsyncSnapshot<List<Emploi>> snapshot) {

    double  screenWidth  = MediaQuery.of(context).size.width;
    double _crossAxisSpacing = 0, _mainAxisSpacing = 0, _aspectRatio = 0.55;
    int _crossAxisCount = 2;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var height = width / _aspectRatio ;

    var bg_colors = [
      {'Colors': Color.fromRGBO(255, 255, 255, 0.9)},
      {'Colors': Color.fromRGBO(255, 255, 255, 0.9)},
      {'Colors': Color.fromRGBO(255, 255, 255, 0.9)},
      {'Colors': Color.fromRGBO(255, 255, 255, 0.9)},
      {'Colors': Color.fromRGBO(255, 255, 255, 0.9)},
      {'Colors':Color.fromRGBO(255, 255, 255, 0.9)},
      ];

    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount,
          crossAxisSpacing: _crossAxisSpacing,
          mainAxisSpacing: _mainAxisSpacing,
          childAspectRatio: _aspectRatio
        ),
        itemBuilder: (BuildContext context, int index) {
          return  ListView(
            padding: EdgeInsets.all(8),

            children: <Widget>[
              Padding(
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
                            ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Container(
                        width: 260,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(snapshot.data[index].aPourvoirLe),
                            ]
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: height/2,
                child:
                     Image.memory(

                        snapshot.data[index].decodeLogo(),
                        fit: BoxFit.contain,
                        color: const Color.fromRGBO(255, 255, 255, 0.5),
                        colorBlendMode: BlendMode.modulate
                    )
                ),
          ],
        );
    });
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Service/EmploiService.dart';

class GridViewWidget extends StatefulWidget {

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

    int _crossAxisCount = 2;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GridView.builder(

        itemCount: snapshot.data.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (BuildContext context, int index) {
          return  ListView(

            padding: EdgeInsets.all(8),
            children: <Widget>[
              InkWell(
                onTap: () => launch(snapshot.data[index].url),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      child:Column(children: <Widget>[
                        SizedBox(
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
                      ]),
                    )

                  ],
                ),
              ),
              SizedBox(
                child:InkWell(
                    onTap: () => launch(snapshot.data[index].url),
                    child:Image.memory(
                    snapshot.data[index].decodeLogo(),
                    fit: BoxFit.contain,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                    colorBlendMode: BlendMode.modulate
                )
                )
                ),
          ],
        );
    });
  }

}


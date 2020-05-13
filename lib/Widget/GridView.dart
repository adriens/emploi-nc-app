import 'package:EmploiNC/Model/Favory.dart';
import 'package:EmploiNC/Provider/DBProvider.dart';
import 'package:EmploiNC/Provider/EmploiSQLITE_api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Service/EmploiService.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
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
  Future<List<Emploi>> favemplois;

  _refresh() {
    emplois = EmploiService.getLatestEmplois("4");
    var apiProvider = EmploiSQLITEApiProvider();
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

    int _crossAxisCount = 1;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 6;
    final double itemWidth = size.width / 2;

    return SingleChildScrollView (
      child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,12.0,0,5.0),
              child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Offres Récentes ",textAlign: TextAlign.left,style:
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                ]
              ),
            ),
            SizedBox(
              height: 260,
              child: GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate:
                  new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,childAspectRatio: 1.4),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () => launch(snapshot.data[index].url),
                      child: Card(
                        child:Container(
                          child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child:InkWell(
                                          onTap: () => launch(snapshot.data[index].url),
                                          child:Image.memory(
                                              snapshot.data[index].decodeLogo(),
                                              fit: BoxFit.contain,
                                              color: const Color.fromRGBO(255, 255, 255, 1),
                                              colorBlendMode: BlendMode.modulate
                                          )
                                      )
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                      child: Container(
                                        width: itemWidth/2,
                                        child: Text(snapshot.data[index].titreOffre,style:
                                        TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ), overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                        child: Container(
                                          width: itemWidth-10,
                                          child: Text(snapshot.data[index].typeContrat,textAlign: TextAlign.center,),
                                      ),
                                    )
                                  ]
                                ),
                                Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                        child: Container(
                                          width: itemWidth-10,
                                          child: Text(snapshot.data[index].communeEmploi,textAlign: TextAlign.center,),
                                        ),
                                      )
                                    ]
                                ),
                                Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                        child: Container(
                                          width: itemWidth-10,
                                          height: 20,
                                          child: Text(snapshot.data[index].aPourvoirLe,textAlign: TextAlign.center,),
                                        ),
                                      )
                                    ]
                                ),
                          ]),
                        ),
                      )
                    );
          }),
        ),


            FutureBuilder(
              future: DBProvider.db.getAllFavEmploiSQLITE(),
              builder: (context, AsyncSnapshot<List<Emploi>> snapshot) {
              if (snapshot.hasData) {
                return  SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        snapshot.data.length > 1 ?
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,20.0,0,5.0),
                            child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:  snapshot.data != null ? Text("Offres Favorites ",textAlign: TextAlign.left,style:
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  ): Center()
                              ),
                            ]
                        ),
                          )
                          :
                          Container(),
                        snapshot.data.length == 1 ?
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,20.0,0,5.0),
                          child: Row(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:  snapshot.data != null ? Text("Offre Favorite ",textAlign: TextAlign.left,style:
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    ): Center()
                                ),
                              ]
                          ),
                        )
                            :
                        Container(),
                        snapshot.data.length == 1 ?
                        Card(
                          child:Container(
                            child: Column(
                            children: <Widget>[
                              Row(
                                  children: <Widget>[
                                    Container(
                                        height: 50,
                                        width: 50,
                                        child:InkWell(
                                            onTap: () => launch(snapshot.data[0].url),
                                            child:Image.memory(
                                              snapshot.data[0].decodeLogo(),
                                              fit: BoxFit.contain,
                                            )
                                        )
                                    ),
                                    Container(
                                      width: size.width-60,
                                      child: Text(snapshot.data[0].titreOffre,style:
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ), overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ]
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                child: Container(
                                  child: Text(snapshot.data[0].typeContrat,textAlign: TextAlign.center,),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                child: Container(
                                  child: Text(snapshot.data[0].communeEmploi,textAlign: TextAlign.center,),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new IconButton(
                                      icon: new Icon(
                                          snapshot.data[0].isFav.toString() == "true" ? Icons.star : Icons.star_border,
                                          color: snapshot.data[0].isFav.toString() == "true"  ? Colors.yellow[200] : Colors.yellow[200],
                                          size: 16.0),
                                      onPressed: () async {
                                        _favOffer(snapshot.data[0].shortnumeroOffre);

                                        if (snapshot.data[0].isFav == "true" ){
                                          await DBProvider.db.updateisFav(snapshot.data[0].shortnumeroOffre,"false");
                                          setState(() {
                                            snapshot.data[0].isFav = "false";
                                          });
                                        } else {
                                          await DBProvider.db.updateisFav(snapshot.data[0].shortnumeroOffre,"true");
                                          setState(() {
                                            snapshot.data[0].isFav = "true";
                                          });
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(220, 3, 0, 3),
                                      child: Container(
                                        child: Text(snapshot.data[0].aPourvoirLe,textAlign: TextAlign.center,),
                                      ),
                                    ),

                                  ]
                              )
                            ]),
                          ),
                        )
                        :
                        SizedBox(
                          height: 150,
                          child: Swiper(
                      autoplay:true,
                      autoplayDelay: 5000,
                      duration: 1000,
                      itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child:Container(
                              child: Column(
                                  children: <Widget>[
                                    Row(
                                        children: <Widget>[
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child:InkWell(
                                                  onTap: () => launch(snapshot.data[index].url),
                                                  child:Image.memory(
                                                    snapshot.data[index].decodeLogo(),
                                                    fit: BoxFit.contain,
                                                  )
                                              )
                                          ),
                                          Container(
                                            width: size.width-60,
                                            child: Text(snapshot.data[index].titreOffre,style:
                                            TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ), overflow: TextOverflow.ellipsis
                                            ),
                                          ),
                                        ]
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: Container(
                                        child: Text(snapshot.data[index].typeContrat,textAlign: TextAlign.center,),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: Container(
                                        child: Text(snapshot.data[index].communeEmploi,textAlign: TextAlign.center,),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          new IconButton(
                                            icon: new Icon(
                                                snapshot.data[index].isFav.toString() == "true" ? Icons.star : Icons.star_border,
                                                color: snapshot.data[index].isFav.toString() == "true"  ? Colors.yellow[200] : Colors.yellow[200],
                                                size: 16.0),
                                            onPressed: () async {
                                              _favOffer(snapshot.data[index].shortnumeroOffre);

                                              if (snapshot.data[index].isFav == "true" ){
                                                await DBProvider.db.updateisFav(snapshot.data[index].shortnumeroOffre,"false");
                                                setState(() {
                                                  snapshot.data[index].isFav = "false";
                                                });
                                              } else {
                                                await DBProvider.db.updateisFav(snapshot.data[index].shortnumeroOffre,"true");
                                                setState(() {
                                                  snapshot.data[index].isFav = "true";
                                                });
                                              }
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(220, 3, 0, 3),
                                            child: Container(
                                              child: Text(snapshot.data[index].aPourvoirLe,textAlign: TextAlign.center,),
                                            ),
                                          ),

                                        ]
                                    )
                                  ]),
                            ),
                          );
                      },
                      itemCount: snapshot.data.length,
                      pagination: new SwiperPagination(),
                    ),
                        )
                      ]
                )
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
                return Center();
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20.0,0,5.0),
              child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("",textAlign: TextAlign.left,style:
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      ),
                    ),
                  ]
              ),
            ),
        ]
      ),
    );
  }
  Future<Null> _favOffer(String numero) async {
    Favory fav = new Favory();
    fav.shortnumeroOffre = numero;
    var apiProvider = EmploiSQLITEApiProvider();
    await apiProvider.favOffer(fav);

    return null;
  }
}


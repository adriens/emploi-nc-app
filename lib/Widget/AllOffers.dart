import 'package:EmploiNC/Model/Favory.dart';
import 'package:EmploiNC/Provider/DBProvider.dart';
import 'package:EmploiNC/Provider/EmploiSQLITE_api_provider.dart';
import 'package:EmploiNC/Variable/Variable.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:esys_flutter_share/esys_flutter_share.dart';
//import 'dart:typed_data'; image share
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

const loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class AllOffers extends StatefulWidget {

  AllOffers({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _AllOffers createState() => _AllOffers();

}

class _AllOffers extends State<AllOffers> {


  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
            child: CircularProgressIndicator(),
      )
          : _buildEmploisListView(),
    );
  }

  Future<Null> _favOffer(String numero) async {
    Favory fav = new Favory();
    fav.shortnumeroOffre = numero;
    var apiProvider = EmploiSQLITEApiProvider();
    await apiProvider.favOffer(fav);

    return null;
  }

  Future<Null> _loadFromApi() async {
//    setState(() {
//      isLoading = true;
//    });

    var apiProvider = EmploiSQLITEApiProvider();
    await apiProvider.getAllEmploiSQLITE("10");

    setState(() {
      isLoading = false;
    });

    return null;
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    //await DBProvider.db.deleteAllEmploiSQLITE();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }



  _buildEmploisListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllEmploiSQLITE(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                _loadFromApi();
                setState(() {
                  isLoading = true;
                });
              },
              child: Text(
              "Activer Cache local",
            ),),
          );
        }else {
          return new RefreshIndicator(
              child:ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black12,
                ),
                itemCount: snapshot.data.length+1,
                itemBuilder: (BuildContext context, int index) {
                  if ( index == 0 ){
                    return Column(
                      children:[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data.length.toString()+" Offres chargées"),
                      )),
                        itemAllOffer(snapshot,context,index)
                      ]
                    );
                  }
                  if (index == snapshot.data.length ){
                    return  Container(
                      child: FlatButton(
                        child: Text("Charger plus"),
                        onPressed: () {
                          // TODO: Attente de la mise à jour de l'api pour charger plus d'offres
                        },
                      ),
                    );
                  }else {
                      return itemAllOffer(snapshot,context,index);
                    }
                },
              ),
              onRefresh: _loadFromApi
          );
        }
      },
    );
  }

  Widget buildLike(snapshot,index) {
    return GestureDetector(
      child: Row(
          children: <Widget>[
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
          ]
      ),
    );
  }

  itemAllOffer(AsyncSnapshot snapshot,BuildContext context, int index){
    return InkWell(
      onTap: () => launch(snapshot.data[index].url),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween,
              children: <Widget>[
                Container(
                  width: 260,
                  child: Text(
                      '${snapshot.data[index].nomEntreprise}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ), overflow: TextOverflow.ellipsis
                  ),
                ),
                Text('${snapshot.data[index].formatDate(
                    snapshot.data[index].datePublication)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    )
                ),
              ]
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.memory(
                    snapshot.data[index].decodeLogo(),
                    fit: BoxFit.contain,
                    color: themeisDark ? Color.fromRGBO(
                        255, 255, 255, 0.5) : Color.fromRGBO(
                        255, 255, 255, 1),
                    colorBlendMode: BlendMode.modulate
                ),
            ),
              title: Text(
                  "${snapshot.data[index].titreOffre}",textAlign: TextAlign.center,
              ),
              isThreeLine: true,
              subtitle: Text(
                  '${snapshot.data[index].typeContrat}'
                      '\n${snapshot.data[index]
                      .communeEmploi}'
                      '\nA pourvoir le: ${snapshot.data[index]
                      .aPourvoirLe}',textAlign: TextAlign.center,
              )
          ),
          ExpandableNotifier(
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  iconColor: themeisDark ? Colors.white : Colors.black,
                  header: Padding(
                    padding: EdgeInsets.all(0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildLike(snapshot,index),
                          GestureDetector(
                              onTap: () {
                                _showShareDialog(
                                    snapshot.data[index]
                                        .titreOffre,
                                    snapshot.data[index]
                                        .typeContrat,
                                    snapshot.data[index]
                                        .communeEmploi,
                                    snapshot.data[index]
                                        .aPourvoirLe,
                                    snapshot.data[index].url
                                );
                              },
                              child: Row(
                                  children: <Widget>[
                                    Icon(Icons.share,
                                        color: Colors
                                            .grey[600],
                                        size: 16.0)
                                  ]
                              )
                          ),
                        ]
                    ),
                  ),
                  collapsed: Text(loremIpsum, softWrap: false,
                    overflow: TextOverflow.ellipsis,),
                  expanded: Text(loremIpsum, softWrap: true,
                    overflow: TextOverflow.fade,),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10.0,
                          right: 10.0,
                          bottom: 10.0),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareMixed(String titreOffre,String contrat,String commune,String pourvoirle,String url) async {
    try {
      final String liensAppli = "https://play.google.com/store/apps/details?id=com.github.adriens.nc.emploi";

//      await Share.files(
//          'esys images',
//          {
//            'qrCode.png': bytes1.buffer.asUint8List(),
//          },
//          'image/png',text: titreOffre+"\nLiens :"+url);
      Share.text(
          'Offres Emploi Nouvelle-Calédonie',
          titreOffre+
              "\n"+contrat+
              "\n"+commune+
              "\n"+pourvoirle+
              "\n\nLien de l'offre:\n"+url+
              "\n\nApplication Mobile:\n"+liensAppli,
          'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  void _showShareDialog(String titreOffre,String contrat,String commune,String pourvoirle,String url) {

    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: url,
            version: QrVersions.auto,
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Qr Code de l'annonce"),
          content: SafeArea(
            top: true,
            bottom: true,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 280,
                        child: qrFutureBuilder,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                        .copyWith(bottom: 40),
                    child: InkWell(
                        child: Text(url, style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                        onTap: () async {
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        }
                    )
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Partager",style: TextStyle(color: Colors.black)),
              onPressed: () async => await _shareMixed(titreOffre,contrat,commune,pourvoirle,url),
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Fermer",style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('images/launchImage.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
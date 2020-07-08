import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Model/Favory.dart';
import 'package:EmploiNC/Provider/DBProvider.dart';
import 'package:EmploiNC/Provider/EmploiSQLITE_api_provider.dart';
import 'package:EmploiNC/Service/EmploiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:esys_flutter_share/esys_flutter_share.dart';

class SearchWidget extends StatefulWidget {

  SearchWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _SearchWidget createState() => _SearchWidget();

}


class _SearchWidget extends State<SearchWidget> {

  // List of Items
  Future<List<Emploi>> emplois;

  final TextEditingController _filter = new TextEditingController();

  bool initPage = true;
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Rechercher');

  Future<Null> _favOffer(String numero,AsyncSnapshot<List<Emploi>> snap,int index) async {

    String lastnumero = await DBProvider.db.isFav(numero);
    print("numero :"+numero+"lastnumero :"+lastnumero);
    if ( numero == lastnumero && snap.data[index].isFav == "true" ){
      await DBProvider.db.updateisFav(snap.data[index].shortnumeroOffre,"false");
      setState(() {
        snap.data[index].isFav = "false";
      });
    } else {
      await DBProvider.db.updateisFav(snap.data[index].shortnumeroOffre,"false");
      await DBProvider.db.updateisFav(snap.data[index].shortnumeroOffre,"true");
      setState(() {
        snap.data[index].isFav = "true";
      });
    }

    Favory fav = new Favory();
    fav.shortnumeroOffre = numero;
    var apiProvider = EmploiSQLITEApiProvider();
    await apiProvider.favOffer(fav);

    return null;
  }

  _refresh()  async {
   emplois = EmploiService.getSearch("20",_searchText,_selectedCommunes,_selectedContrat,_valueDateStart,_valueDateEnd);

   OverlayState overlayState = Overlay.of(context);
   OverlayEntry overlayEntry = new OverlayEntry(builder: _buildLoader);
   overlayState.insert(overlayEntry);
   await emplois;
   overlayEntry.remove();

   setState(() {
     initPage = false;
   });

  }

  _refreshInit() {
    emplois = EmploiService.getSearch("20",_searchText,_selectedCommunes,_selectedContrat,_valueDateStart,_valueDateEnd);
  }

  @override
  void initState() {
    super.initState();
    _refreshInit();
  }

  _SearchWidget() {
    _filter.addListener(() {
      if ( _filter.text.isEmpty ) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  bool loading = false;
  List<String> _contrats = ['Tout','CDD', 'CDI','CDD évolutif'];
  String _selectedContrat ='Tout';

  List<String> _communes = ['Toutes','Thio', 'Yaté','Île des Pins','Mont-Dore','Nouméa','Dumbéa','Païta','Boulouparis','La Foa','Sarraméa','Farino','Moindou','Bourail','Poya'
  'Pouembout','Koné','Voh','Kaala-Gomen','Koumac','Poum','Bélep','Ouégoa','Pouébo','Hienghène','Touho','Poindimié','Ponérihouen','Houaïlou','Kouaoua','Canala',
    'Ouvéa','Lifou','Maré'];
  String _selectedCommunes ='Toutes';

  String _valueDateStart = '';
  String _valueDateEnd = '';
  DateTime start;
  DateTime end;

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar:_buildBar(context),
          resizeToAvoidBottomPadding: false,
          body:TabBarView(
            children: <Widget>[
              OfflineBuilder(
                connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                    ) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  return new Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child:  connected ? Column(
                          children: <Widget>[
                            initPage ? Text('Chargement des 20 dernières Offres') : Container(),
                            Expanded(child:_buildList(context))
                          ],
                        ) : Text("Hors Ligne"),
                      ),
                    ],
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                  ],
                ),
              ),
              OfflineBuilder(
                connectivityBuilder: (
                    BuildContext context,
                    ConnectivityResult connectivity,
                    Widget child,
                    ) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  return new Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child:  connected ? Column(
                            children:<Widget> [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(

                                      child: Text("Contrat",style:
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ), overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),

                                  DropdownButton(
                                    hint: Text('Contrat'), // Not necessary for Option 1
                                    value: _selectedContrat,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedContrat = newValue;
                                      });
                                    },
                                    items: _contrats.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),


                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(

                                      child: Text("Commune",style:
                                      TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ), overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),
                                  DropdownButton(
                                    hint: Text('Communes'), // Not necessary for Option 1
                                    value: _selectedCommunes,
                                    onChanged: (newValue2) {
                                      setState(() {
                                        _selectedCommunes = newValue2;
                                      });
                                    },
                                    items: _communes.map((location2) {
                                      return DropdownMenuItem(
                                        child: new Text(location2),
                                        value: location2,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              Container(
                                  child: Text("Intervalle de date de prise de poste :")
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  RaisedButton( onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 1, 1),
                                        maxTime: DateTime(2021, 12,12), onChanged: (date) {
                                        }, onConfirm: (date) {
                                          setState(() {
                                            start = date;

                                            String day = "0";
                                            String month = "0";
                                            date.day.toString().length == 2 ? day =  date.day.toString() : day = day + date.day.toString();
                                            date.month.toString().length == 2 ? month =  date.month.toString() : month = month + date.month.toString();
                                            if ( _valueDateEnd.isNotEmpty && start.isAfter(end)) {
                                              String tmp = _valueDateEnd.toString();
                                              _valueDateEnd = day+"/"+month+"/"+date.year.toString();
                                              _valueDateStart = tmp;
                                            }else{
                                              _valueDateStart = day+"/"+month+"/"+date.year.toString();
                                            }

                                          });
                                        }, currentTime: DateTime.now(), locale: LocaleType.fr);
                                  },
                                      child: Text(
                                          "Début"
                                      )),
                                  RaisedButton( onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 1, 1),
                                        maxTime: DateTime(2021, 12,12), onChanged: (date) {
                                        }, onConfirm: (date) {
                                          setState(() {
                                            end = date;
                                            String day = "0";
                                            String month = "0";
                                            date.day.toString().length == 2 ? day =  date.day.toString() : day = day + date.day.toString();
                                            date.month.toString().length == 2 ? month =  date.month.toString() : month = month + date.month.toString();
                                            if ( _valueDateStart.isNotEmpty && start.isAfter(end)) {
                                              String tmp = _valueDateStart.toString();
                                              _valueDateStart = day+"/"+month+"/"+date.year.toString();
                                              _valueDateEnd = tmp;

                                            }else{
                                              _valueDateEnd = day+"/"+month+"/"+date.year.toString();
                                            }

                                          });
                                        }, currentTime: DateTime.now(), locale: LocaleType.fr);
                                  },
                                      child: Text(
                                          "Fin"
                                      )),
                                ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        _valueDateStart
                                    ),
                                    Text(
                                        _valueDateEnd
                                    ),
                                  ]),

                              Center(
                                  child:  RaisedButton(
                                    padding: const EdgeInsets.all(8.0),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    onPressed: _refresh,
                                    child: new Text("Appliquer filtre"),
                                  )
                              ),

                            ]
                        ) : Text("Hors Ligne"),
                      ),
                    ],
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        children:<Widget> [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(

                                  child: Text("Contrat",style:
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ), overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),

                              DropdownButton(
                                hint: Text('Contrat'), // Not necessary for Option 1
                                value: _selectedContrat,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedContrat = newValue;
                                  });
                                },
                                items: _contrats.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),


                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(

                                  child: Text("Commune",style:
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ), overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),
                              DropdownButton(
                                hint: Text('Communes'), // Not necessary for Option 1
                                value: _selectedCommunes,
                                onChanged: (newValue2) {
                                  setState(() {
                                    _selectedCommunes = newValue2;
                                  });
                                },
                                items: _communes.map((location2) {
                                  return DropdownMenuItem(
                                    child: new Text(location2),
                                    value: location2,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          )
      ),

    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(

      centerTitle: true,
      title: new TextField(
        controller: _filter,
        decoration: new InputDecoration(
            hintText: 'Tapez Votre Recherche ...'
        )),
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      bottom: TabBar(
        tabs: [
          Tab(child:  new Text('Offres')),
          Tab(child:  new Text('Avancées')),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder<List<Emploi>>(
          future: emplois,
          builder: (BuildContext context, AsyncSnapshot<List<Emploi>> snapshot) {
            if ( snapshot.hasData ) {
              return  ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder:(BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        index == 0 && !initPage && snapshot.data.length > 1 ? Text('Chargement de '+snapshot.data.length.toString()+' Offres') : snapshot.data.length == 1 ? Text("Chargement d'une offre d'emploi.") : Container(),
                        Card(
                        elevation: 3,
                        child: InkWell(
                            onTap: () => launch(snapshot.data[index].url),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 105.0,
                                  width: 80.0,
                                  padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                  child: new Image.memory(  snapshot.data[index].decodeLogo(),fit: BoxFit.contain  ),
                                ),
                                Container(
                                  height: 105,
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
                                                  new IconButton(
                                                    icon: new Icon(
                                                        snapshot.data[index].isFav == "true" ? Icons.star : Icons.star_border,
                                                        color: snapshot.data[index].isFav == "true" ? Colors.yellow[200] : Colors.yellow[200],
                                                        size: 16.0),
                                                    onPressed: () async {
                                                      _favOffer(snapshot.data[index].shortnumeroOffre,snapshot,index);
                                                    },
                                                  ),
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
                    ),
                    ]
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }else if ( snapshot.data == null && _searchText.isNotEmpty ){
              return Center(child: Text("Pas d'offres d'emplois correspondante"));
            }
            return ListView.builder(
                itemCount: 10,
                // Important code
                itemBuilder: (context, index) => Shimmer.fromColors(
                  child: Card (
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 105,
                            ),
                          ],
                        ),
                      )
                  ),
                  baseColor: Colors.black12,
                  highlightColor: Colors.black26,
                ));
          }
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('images/launchImage.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }

  Future<void> _shareMixed(String titreOffre,String contrat,String commune,String pourvoirle,String url) async {

    try {
      final String liensAppli = "https://play.google.com/store/apps/details?id=com.github.adriens.nc.emploi";
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

  Widget _buildLoader(BuildContext context){
    return Center(child: CircularProgressIndicator());
  }

  Future<void> _searchPressed() async {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        _refresh();
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Tapez Votre Recherche ...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle =  new Text( 'Rechercher');
        _filter.clear();
        _refresh();
      }
    });
  }

}
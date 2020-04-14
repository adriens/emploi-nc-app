import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Service/EmploiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:url_launcher/url_launcher.dart';


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

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Rechercher');

  // List of Items
  Future<List<Emploi>> emplois;

  _refresh() async {
    emplois = EmploiService.getLatestEmplois("25");
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

  @override
  void initState() {
    _refresh();
    super.initState();
  }


  List<String> _contrats = ['Tout','CDD', 'CDI','CDD évolutif'];
  String _selectedContrat ='Tout';

  List<String> _communes = ['Toutes','Thio', 'Yaté','Île des Pins évolutif','Mont-Dore','Nouméa','Dumbéa','Païta','Boulouparis','La Foa','Sarraméa','Farino','Moindou','Bourail','Poya'
  'Pouembout','Koné','Voh','Kaala-Gomen','Koumac','Poum','Bélep','Ouégoa','Pouébo','Hienghène','Touho','Poindimié','Ponérihouen','Houaïlou','Kouaoua','Canala',
    'Ouvéa','Lifou','Maré'];
  String _selectedCommunes ='Toutes';

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
                        child:  connected ? _buildList() : Text("Hors Ligne"),
                      ),
                    ],
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     _buildList(),
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
      title: _appBarTitle,
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

  Widget _buildList() {
    return FutureBuilder<List<Emploi>>(
        future: emplois,
        builder: (BuildContext context, AsyncSnapshot<List<Emploi>> snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting)
            return Column(
              children: <Widget>[
                Text('Chargement des 25 dernières Offres'),
                Expanded(child: Center( child: CircularProgressIndicator() ))
              ]
            );


          return  ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ( _searchText == null || _searchText == "" )
                    && ( _selectedContrat == null || _selectedContrat == "Tout" )
                    && ( _selectedCommunes == null || _selectedCommunes == "Toutes" ) ?
                  new Card(
                    elevation: 3,
                    child: InkWell(
                        onTap: () => launch(snapshot.data[index].url),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              height: 100.0,
                              width: 80.0,
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                              child: new Image.memory(snapshot.data[index].decodeLogo(),fit: BoxFit.contain  ),
                            ),
                            new Container(
                              height: 100,
                              child: new Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                      child: new Container(
                                        width: 260,
                                        child: new Text(snapshot.data[index].titreOffre,style:
                                        new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ), overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: new Container(
                                        decoration: new BoxDecoration(
                                        ),
                                        child: new Text(snapshot.data[index].typeContrat,textAlign: TextAlign.center,),
                                      ),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: new Container(
                                        width: 260,
                                        child: new Row(
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
                )
                  : snapshot.data[index].titreOffre.contains(_searchText) &&
                    ( snapshot.data[index].typeContrat.contains(_selectedContrat) || _selectedContrat == "Tout" ) &&
                    ( snapshot.data[index].communeEmploi.contains(_selectedCommunes) || _selectedCommunes == "Toutes" ) ?
                  new Card(
                    elevation: 3,
                    child: new InkWell(
                        onTap: () => launch(snapshot.data[index].url),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              height: 100.0,
                              width: 80.0,
                              padding: new EdgeInsets.fromLTRB(10, 2, 0, 0),
                              child: new Image.memory(snapshot.data[index].decodeLogo(),fit: BoxFit.contain  ),
                            ),
                            new Container(
                              height: 100,
                              child: new Padding(
                                padding: new EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Padding(
                                      padding: new EdgeInsets.fromLTRB(0, 5, 0, 2),
                                      child: new Container(
                                        width: 260,
                                        child: new Text(snapshot.data[index].titreOffre,style:
                                        new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ), overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: new Container(
                                        decoration: new BoxDecoration(
                                        ),
                                        child: new Text(snapshot.data[index].typeContrat,textAlign: TextAlign.center,),
                                      ),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: new Container(
                                        width: 260,
                                        child: new Row(
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
                )
                  : new Container();
              });
        }
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
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
      }
    });
  }

}
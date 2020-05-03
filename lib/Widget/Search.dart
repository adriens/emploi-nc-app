import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/Service/EmploiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:shimmer/shimmer.dart';

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

  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Rechercher');

  DatePickerController _controllerDebut = DatePickerController();
  DatePickerController _controllerFin = DatePickerController();

  _refresh()  async {
   emplois = EmploiService.getSearch("20",_searchText,_selectedCommunes,_selectedContrat,_selectedDateDebut,_selectedDateFin);

   OverlayState overlayState = Overlay.of(context);
   OverlayEntry overlayEntry = new OverlayEntry(builder: _buildLoader);
   overlayState.insert(overlayEntry);
   await emplois;
   overlayEntry.remove();

  }
  _refreshInit() {
    emplois = EmploiService.getSearch("20",_searchText,_selectedCommunes,_selectedContrat,_selectedDateDebut,_selectedDateFin);
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

  DateTime _selectedDateFin = DateTime.now();
  DateTime _selectedDateDebut = new DateTime.now().subtract(new Duration(days: 7));

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
                        child:  connected ? _buildList(context) : Text("Hors Ligne"),
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
                              child: Text("Date Prise de poste au plus tot")
                              ),
                              Container(
                              child: DatePicker(
                                  DateTime.now().add(Duration(days: -30)),
                                  width: 60,
                                  height: 80,
                                  controller: _controllerDebut,
                                  locale :'fr',
                                  initialSelectedDate:  _selectedDateDebut,
                                  selectionColor: Colors.black,
                                  selectedTextColor: Colors.white,
                                  onDateChange: (date) {
                                  // New date selected
                                  setState(() {
                                    _selectedDateDebut = date;
                                });
                                },
                                )
                              ),
                              Container(
                                  child: Text("Date Prise de poste au plus tard")
                              ),
                              Container(
                                  child: DatePicker(
                                    DateTime.now().add(Duration(days: -7)),
                                    width: 60,
                                    height: 80,
                                    controller: _controllerFin,
                                    locale :'fr',
                                    initialSelectedDate: _selectedDateFin,
                                    selectionColor: Colors.black,
                                    selectedTextColor: Colors.white,
                                    onDateChange: (date) {
                                      // New date selected
                                      setState(() {
                                        _selectedDateFin = date;
                                      });
                                    },
                                  )
                              ),
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
                                  child: new Image.memory(  snapshot.data[index].decodeLogo(),fit: BoxFit.contain  ),
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
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
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
                              height: 100.0,
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
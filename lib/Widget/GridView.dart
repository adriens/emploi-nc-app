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
                                              color: const Color.fromRGBO(255, 255, 255, 0.5),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20.0,0,5.0),
              child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Offres Favorites ",textAlign: TextAlign.left,style:
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                              child: Container(
                                child: Text(snapshot.data[index].aPourvoirLe,textAlign: TextAlign.center,),
                              ),
                            ),
                          ]),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
                pagination: new SwiperPagination(),
              )
            ),
        ]
      ),
    );
  }

}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutWidget extends StatefulWidget {

  AboutWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _AboutWidget createState() => _AboutWidget();

}

class _AboutWidget extends State<AboutWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(

      children: [
        Card(
          child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
            ),
            Center(
              child:  Image(image: AssetImage('images/launchImage.png')),
            ),
            Container(
              width: 200,
              child: Center(
                heightFactor: 3,
                child: Text('Application mobile des offres emplois en Nouvelle-Calédonie'),
              ),
            ),
            Center(
              child: Image.asset(
                'images/qr-code-google-play-store.png',
                height: 250,
                width: 250,
              ),
            ),
            Divider(),
            ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("images/emploigouvnc.png"),
                    ),
                    new Text("Emploi.gouv.nc"),
                  ]
              ),
            ),


            Divider(),
            ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("Nom"),
                    new Text("Offres Emplois Calédonie")
                  ]
              ),
            ),
            Divider(),
            ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("Version"),
                    new Text("1.0.9")
                  ]
              ),
            ),
          ],
        ),
      ),]
    );
  }
}
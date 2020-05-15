import 'package:EmploiNC/Variable/Variable.dart';
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
              padding: EdgeInsets.all(10.0),
            ),
            Center(
              child:  Image(image: AssetImage('images/launchImage.png')),
            ),
            Container(
              width: 180,
              child: Center(
                heightFactor: 3,
                child: Text("Application mobile des offres d'emplois en Nouvelle-Calédonie",textAlign: TextAlign.center),
              ),
            ),
            Center(
              child: Image.asset(
                'images/qr-code-google-play-store.png',
                height: 230,
                width: 230,
              ),
            ),
            Divider(),

            ListTile(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(version,textAlign: TextAlign.center),
                  ]
              ),
            ),
          ],
        ),
      ),]
    );
  }
}
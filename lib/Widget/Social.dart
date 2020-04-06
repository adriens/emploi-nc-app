import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialWidget extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Social"),
    );
  }
  SocialWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _SocialWidget createState() => _SocialWidget();

}

class _SocialWidget extends State<SocialWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  static const String _title = 'Social';

  @override
  Widget build(BuildContext context) {
    final names = [
      'Sites Officiel : Emploi.gouv.nc',
      'Website',
      'Github',
      'Youtube',
      'Twitter'
    ];
    final img = [
      'emploigouvnc.png',
      'launchImage.png',
      'github.jpg',
      'ytbe.png',
      'twitter.png'
    ];
    final url = [
      'https://emploi.gouv.nc/',
      'https://adriens.github.io/emploi-nc-website',
      'https://github.com/adriens/emploi-nc-app',
      'https://www.youtube.com/playlist?list=PLVaySOddZPMer1H6o234RyWhEfSThuYW5',
      'https://twitter.com/NcEmploi'
    ];
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
      return Container(
          height: 100,
          child: Card(
            child: ListTile(
              onTap: () => launch(url[index]),
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/"+img[index]),
              ),
              title: Text(names[index]),
              subtitle: Text(url[index]),
            ),
          )
        );
      }
    );
  }
}
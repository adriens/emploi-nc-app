import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class CollaborateursWidget extends StatefulWidget {

  CollaborateursWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _CollaborateursWidget createState() => _CollaborateursWidget();

}

class _CollaborateursWidget extends State<CollaborateursWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final names = [
      'Adrien Sales',
      'Ronny Soutart',
      'Emilie Bossart',
      'Jimmy Avae'
    ];
    final img = [
      'adriensales.png',
      'ronnysoutart.jpg',
      'emiliebossart.png',
      'jimmyavae.png'
    ];
    final desc = [
      'CEO/CIO',
      'Conseil dév. Flutter et ergonomie',
      'Graphic Designer',
      'Lead Developer'
    ];
    final twitter = [
      'https://twitter.com/rastadidi',
      '',
      '',
      '',
    ];
    final linkedin = [
      'https://www.linkedin.com/in/adrien-sales',
      'https://www.linkedin.com/in/ronny-soutart',
      'https://www.linkedin.com/in/émilie-bossart',
      'https://www.linkedin.com/in/jimmy-avae'
    ];
    final github  = [
      'https://github.com/adriens',
      'https://github.com/HakumenNC',
      'https://github.com/meilie389',
      'https://github.com/zYmMiJ'
    ];

      return new Swiper(
        itemBuilder: (BuildContext context,int index){
          return ListView(
                  children: [
                    Card(
                      child: new Container(
                        padding: new EdgeInsets.all(32.0),
                        child: new Column(
                          children: <Widget>[
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage("images/"+img[index]),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(names[index]),
                                Text(desc[index]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () => launch(github[index]),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/github.jpg"),
                        ),
                        title: Text("Github"),
                        subtitle: Text(github[index]),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () => launch(linkedin[index]),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/linkedin.png"),
                        ),
                        title: Text("LinkedIn"),
                        subtitle: Text(linkedin[index]),
                      ),
                    ),
                    buildTwitter(context,twitter[index])
                  ],
          );
        },
        itemCount: names.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      );

  }

  Widget buildTwitter(BuildContext context,twitter) {
    if ( twitter != "" ){
      return Card(
        child: ListTile(
          onTap: () => launch(twitter),
          leading: CircleAvatar(
            backgroundImage: AssetImage("images/twitter.png"),
          ),
          title: Text("Twitter"),
          subtitle: Text(twitter),
        ),
      );
    }else{
      return Divider();
    }

  }
}
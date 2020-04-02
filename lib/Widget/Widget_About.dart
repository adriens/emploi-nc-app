import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutWidget extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("About"),
    );
  }
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

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  static const String _title = 'About';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text(_title),
    );
  }
}
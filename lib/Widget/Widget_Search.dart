import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Search"),
    );
  }
  SearchWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _SearchWidget createState() => _SearchWidget();

}

class _SearchWidget extends State<SearchWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  static const String _title = 'Search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text(_title),
    );
  }
}
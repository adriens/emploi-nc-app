import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsWidget extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Stats"),
    );
  }
  StatsWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _StatsWidget createState() => _StatsWidget();

}

class _StatsWidget extends State<StatsWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  static const String _title = 'Stats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text(_title),
    );
  }
}
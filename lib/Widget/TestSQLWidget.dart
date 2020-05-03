import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestSQLWidget extends StatefulWidget {

  TestSQLWidget({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _TestSQLWidget createState() => _TestSQLWidget();

}

class _TestSQLWidget extends State<TestSQLWidget> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static const String _title = 'SQLite';

  @override
  Widget build(BuildContext context) {

    return Text(_title);
  }
}
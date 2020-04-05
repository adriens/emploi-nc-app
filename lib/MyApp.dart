import 'package:EmploiNC/RoutePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoutePage(),
    );
  }
}
import 'package:EmploiNC/Variable/Variable.dart';
import 'package:EmploiNC/Widget/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: themeisDark ? themebrightnessDark: themebrightnessLight,
        primaryColor: primaryColor,
      ),
      darkTheme: ThemeData(
        primaryColor: primaryColor,
        brightness: themeisDark ? themebrightnessDark: themebrightnessLight,
      ),
      home: SearchWidget(),
    );
  }
}
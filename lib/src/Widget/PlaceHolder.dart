import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final StatelessWidget screen;

  PlaceholderWidget(this.screen);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: screen,
    );
  }
}
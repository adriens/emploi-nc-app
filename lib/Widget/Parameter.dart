import 'package:EmploiNC/Variable/Variable.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Parameter extends StatefulWidget {

  Parameter({
    Key key,
    this.title,
  }): super(key : key);

  final String title;

  @override
  _Parameter createState() => _Parameter();

}


class _Parameter extends State<Parameter> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(

        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Mode Sombre"),
                  Switch(
                    value: themeisDark,
                    onChanged: (value) {

                      setState(() {
                        changeBrightness();
                        themeisDark = value;
                      });
                    },
                    activeTrackColor: secondaryColor,
                    activeColor: primaryColor,
                  ),
                ]
              ),
              Divider(),
            ],
          ),
        ]
    );
  }

  void changeBrightness() {
    print("Dark");
    DynamicTheme.of(context).setBrightness(Brightness.dark);
  }
}
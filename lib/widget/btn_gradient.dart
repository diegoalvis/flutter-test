import 'package:flutter/material.dart';

import 'style_method.dart';

class BtnGradient extends StatelessWidget {
  const BtnGradient(
     this.text,
      {
    Key? key,
    required this.colorGradient,
    required this.textStyle,
  }) : super(key: key);

  final List<Color> colorGradient;
  final TextStyle textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.all(0),
      child: Container(
          decoration: StylesMethodsApp()
              .decorarStyle(colorGradient, 30, Alignment.bottomCenter, Alignment.topCenter),
          padding: EdgeInsets.symmetric(vertical: 9),
          alignment: Alignment.center,
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          )),
      onPressed: () {},
    );
  }
}

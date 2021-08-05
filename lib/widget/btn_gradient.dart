import 'package:bogota_app/data/model/request/register_request.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/pages/register_user/register_user_view_model.dart';
import 'package:flutter/material.dart';

import 'style_method.dart';

class BtnGradient extends StatelessWidget {
   BtnGradient(
     this.text,
      {
    Key? key,
    required this.colorGradient,
    required this.textStyle,
    this.onPressed


  }) : super(key: key);

  final List<Color> colorGradient;
  final TextStyle textStyle;
  final String text;
  final VoidCallback ? onPressed;
  //RegisterRequest ? data;


  @override
  Widget build(BuildContext context) {


    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
          decoration: StylesMethodsApp()
              .decorarStyle(colorGradient, 30, Alignment.bottomCenter, Alignment.topCenter),
          padding: EdgeInsets.symmetric(vertical: 9),
          alignment: Alignment.center,
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          )),
      onPressed:onPressed
    );

  }
}

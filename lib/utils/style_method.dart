import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StylesMethodsApp{

  BoxDecoration decorarStyle(List<Color> colorgrad, double radius, var begin, var end) {
    return  BoxDecoration(
      gradient: LinearGradient(
        colors: colorgrad,
        begin: begin,
        end: end,
      ),
      borderRadius: BorderRadius.circular(radius)
    );
  }

}
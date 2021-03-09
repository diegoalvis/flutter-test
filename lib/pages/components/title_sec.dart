import 'package:bogota_app/pages/components/gradientIcon.dart';
import 'package:flutter/material.dart';
import 'file:///D:/TBBC/ServInformacionIDTBogota/Aplicacion/bogota-app/lib/widget/style_method.dart';


class Title_Sec extends StatelessWidget{
  Title_Sec(this.title,{Key? key}) : super(key: key);
  final String title;


  final stylemethod= StylesMethodsApp();
  final ic = GradientIcon();


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 40,
        //  color: Colors.white,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );

  }



}
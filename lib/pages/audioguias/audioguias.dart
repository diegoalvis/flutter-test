import 'package:bogota_app/data/testData.dart';
import 'package:bogota_app/pages/components/appbar.dart';
import 'package:bogota_app/pages/components/verticalgrid.dart';
import 'package:bogota_app/pages/components/verticalgridcustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/bogota_icon.dart';



class Audioguias extends StatefulWidget {
  static const String routeName = "/Audioguias";
  @override
  _AudioguiasState createState() => _AudioguiasState();
}

class _AudioguiasState extends State<Audioguias> {
  @override
  final a = AppBar_Component();
  final g = GridVerticalCustom_Component();
  final testdata = testData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar_Component() ,
      body: CustomScrollView(

          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(height: 120,
                child: Center(
                  child: Container(
                    height: 60,
                    width: 350,

                    child: Container(

                      margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      child: Text("AUDIOGUÍAS", style: TextStyle(fontFamily: 'MuseoSans', fontWeight: FontWeight.bold,color: Color(0xFF505050), fontSize: 16),),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2.0, color: Color(0xFF505050)),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                ),),
            ),

            g.GridVerticalCustom(context, testdata.imgList2, testdata.textList2, 1),

          ]
      ),
    );
  }
}



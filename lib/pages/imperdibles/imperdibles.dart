import 'package:bogota_app/data/testData.dart';
import 'package:bogota_app/pages/components/appbar.dart';
import 'package:bogota_app/pages/components/verticalgrid.dart';
import 'package:bogota_app/pages/components/verticalgridcustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Imperdibles extends StatefulWidget {
  static const String routeName = "/Imperdibles";
  @override
  _ImperdiblesState createState() => _ImperdiblesState();
}

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100,100,400,100];
class _ImperdiblesState extends State<Imperdibles>  {
  @override
  final a = AppBar_Component();
  final g = GridVerticalCustom_Component();
  final testdata = testData();
  int tap=1;
  List loadList=[];
  List loadTextList=[];


  void initState() {
    // TODO: implement initState
    super.initState();
    _setgridState(tap);
  }
  void _setgridState(int tap){
    setState(() {
      if (tap==1){
        loadList=testdata.imgList2;
        loadTextList=testdata.textList2;
      }
      else{
        loadList=testdata.imgList3;
        loadTextList=testdata.textList3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar_Component() ,
      body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(height: 100,
                child: Center(
                  child: Container(
                    height: 100,
                    width: 350,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 30),
                        alignment: Alignment.center,
                        child: Text("IMPERDIBLES", style: TextStyle(fontFamily: 'MuseoSans', fontWeight: FontWeight.bold,color: Color(0xFF505050), fontSize: 16),),

                      ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.black),
                      ),
                      color: Colors.transparent,
                    ),
                      ),
                ),),
            ),
            SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: Column(children: [
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                         // tap=!tap;
                          _setgridState(1);
                        },
                        child: Container(child: Text("Recomendados", style: TextStyle(fontFamily: 'MuseoSans', fontWeight: FontWeight.bold,color: Color(0xFF505050), fontSize: 14)),)),
                    Container(child: null,width: 80,),
                    InkWell(
                        onTap: () {
                          _setgridState(2);
                         // tap=!tap;
                        },
                        child: Container(child: Text("Mejor Calificados",style: TextStyle(fontFamily: 'MuseoSans', fontWeight: FontWeight.bold,color: Color(0xFF505050), fontSize: 14)),))
                  ],
                )
              ],),
            ),

            ),
    SliverToBoxAdapter(child: SizedBox(height: 30,),),
    g.GridVerticalCustom(context, loadList, loadTextList, 2),

    ]
    ),
    );
  }
}



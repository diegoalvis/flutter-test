import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/mock/data/testData.dart';

import 'package:bogota_app/pages/components/appbar.dart';
import 'package:bogota_app/pages/components/verticalgridcustom.dart';
import 'package:bogota_app/pages/home_old/home.dart';
import 'package:bogota_app/pages/components/read_more_text.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../app_theme.dart';

class Mas_Alla extends StatefulWidget {
  static const String routeName = "/MasAlla";
  @override
  _Mas_AllaState createState() => _Mas_AllaState();
}

class _Mas_AllaState extends State<Mas_Alla> {
  @override
  final a = AppBar_Component();
  final g = GridVerticalCustom_Component();
  final testdata = testData();
  final stylemethod = StylesMethodsApp();

  String title = 'Long List';
  String prevTitle = '';
  late List<String> items;
  late List<String> duplicateItems;
  late TextEditingController textController;
  late ScrollController con;
  final itemSize = 80.0;

  void initState() {
    // TODO: implement initState
    super.initState();
    items = testdata.imgList2;
    duplicateItems = List.from(items);
    textController = TextEditingController();
    prevTitle = title;
    con = ScrollController();
    con.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {
        setState(() {
          title = "reached the bottom";
        });
      } else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {
        setState(() {
          title = "reached the top";
        });
      } else {
        setState(() {
          title = prevTitle;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
            child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image(
                  image: AssetImage(IdtAssets.splash),
                ),
              ),
            ),
            Positioned(
                left: 90,
                bottom: 140,
                child: Container(
                  child: RatingBar.builder(
                    initialRating: 4.3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                )),
            Positioned(
                left: 330,
                bottom: 147,
                child: Text(
                  "4.3/5",
                  style: TextStyle(color: Colors.white),
                )),
            Positioned(
                left: 60,
                bottom: 90,
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    "PARQUE METROPOLITANO SIMÓN BOLIVAR",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: textTheme.titleWhite,
                  ),
                )),
            Positioned(
              top: 0,
              child: Container(
                color: Colors.transparent,
                //  width: double.infinity,
                // height: double.infinity,
                height: 100,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10.0),
                        child: IconButton(
                          autofocus: false,
                          //   padding: EdgeInsets.only(right: 40),
                          //   mouseCursor: ,
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Home.routeName,
                              arguments: Home(
                                state: true,
                                i: 1,
                                newscreen: true,
                              ),
                            );
                            print("appbar");
                            //    Navigator.pushNamed(context, Profile.routeName, arguments: Profile(state: state_profile,),);
                            //    Navigator.pushNamed(context, Chat.routeName);
// do something
                          },
                        ),
                      ),
                    ),
                    //Container(child: ,)
                    Container(
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            height: 50,
                            //width: MediaQuery.of(context).size.width *.125,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                autofocus: false,
                                //   padding: EdgeInsets.only(right: 40),
                                //   mouseCursor: ,
                                color: Colors.transparent,
                                alignment: Alignment.centerRight,
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  print("appbar");
                                  //    Navigator.pushNamed(context, Profile.routeName, arguments: Profile(state: state_profile,),);
                                  //    Navigator.pushNamed(context, Chat.routeName);
// do something
                                },
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            height: 50,
                            // width: MediaQuery.of(context).size.width *.125,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                autofocus: false,
                                //   padding: EdgeInsets.only(right: 40),
                                //   mouseCursor: ,
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                icon: Icon(
                                  IdtIcons.heart2,
                                  color: Colors.red,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  print("appbar");
                                  //    Navigator.pushNamed(context, Profile.routeName, arguments: Profile(state: state_profile,),);
                                  //    Navigator.pushNamed(context, Chat.routeName);
// do something
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
/*                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  AssetImage("lib/assets/curve1.png")
                            ),
                          ),*/
                    alignment: Alignment.bottomLeft,
                    //   height: MediaQuery.of(context).size.height * .5,
                    child: Container(
                      width: 410,
                      height: 130,
                    )))
          ],
        )),

        SliverToBoxAdapter(
          child: Container(
              height: 45,
              margin: EdgeInsets.only(top: 10),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    //    height: 40.0,
                    child: RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      //  splashColor: Colors.white,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: stylemethod.decorarStyle(
                          IdtGradients.blue,
                          20,
                          Alignment.bottomRight,
                          Alignment.topLeft,
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: 150.0,
                              minWidth: 150,
                              minHeight: 50.0,
                              maxHeight: 50),
                          alignment: Alignment.center
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 100,
                    height: 50.0,
                    child: RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: stylemethod.decorarStyle(
                          IdtGradients.blue,
                          30,
                          Alignment.bottomLeft,
                          Alignment.topRight,
                        ),
                        child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 150.0,
                                minWidth: 150,
                                minHeight: 50.0,
                                maxHeight: 50),
                            alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),

        SliverToBoxAdapter(
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              fontSize: 16.0,
              //fontFamily: 'monospace',
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(50.0),
                    child: ReadMoreText(
                      'Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,',
                      textAlign: TextAlign.justify,
                      trimLines: 20,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'SEGUIR LEYENDO',
                      trimExpandedText: ' LEER MENOS',
                      style: TextStyle(
                          fontFamily: 'MuseoSans',
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
            child: Stack(
              children: [

                Stack(
          children: [
                Container(
                    margin: EdgeInsets.only(bottom: 0, top: 0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    color: Colors.white,
                    child: ListView.builder(
                      controller: con,
                      itemCount: testdata.imgList2.length,
                      shrinkWrap: true,
                      itemExtent: MediaQuery.of(context).size.width,

                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                        //     crossAxisAlignment: CrossAxisAlignment.stretch,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //   mainAxisSize: MainAxisSize.max ,

                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                  //  margin: EdgeInsets.only(left: 12,right: 12, top: 17),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0),
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topRight:
                                          Radius.circular(0.00), // FLUTTER BUG FIX
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey[600]!,
                                        offset: Offset(0, 0),
                                        blurRadius: 11.0,
                                      ),
                                    ],
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(0.0),
                                        child: Container(
                                          // height: 200,
                                          // width: 220,
                                          width: MediaQuery.of(context).size.width,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.5,
                                          color: Colors.white,
                                          // margin: EdgeInsets.all(5),
                                          child: Image.network(
                                            testdata.imgList2[index],
                                            width:
                                                MediaQuery.of(context).size.width,
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.5,
                                            //height: 200,
                                            //width: 220,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  )),

                            ],
                          ),
                        ],
                      ),

                      //  itemCount: imgList.length
                    )),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.98,
                  //  top: 0.1,
                  //  bottom: 0.0,
                  // left: 0.1,
                  right: MediaQuery.of(context).size.width * 0.08,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180.0, left: 20),
                    child: IconButton(
                        iconSize: 35,
                        alignment: Alignment.centerLeft,
                        icon: FittedBox(
                          alignment: Alignment.center,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.grey[900],
                            ),
                            onPressed: () {
                              con.animateTo(con.offset - itemSize,
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500));
                            },
                          ),
                        ),
                      onPressed: () {  },),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.98,
                  //  top: 0.1,
                  //  bottom: 0.0,
                  left: MediaQuery.of(context).size.width * 0.74,
                  // right: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 175.0, left: 45),
                    child: IconButton(
                        iconSize: 35,
                        alignment: Alignment.centerLeft,
                        icon: FittedBox(
                          alignment: Alignment.center,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey[900],
                            ),
                            onPressed: () {
                              con.animateTo(con.offset + itemSize,
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500));
                            },
                          ),
                        ),
                      onPressed: () {  },),
                  ),
                )
          ],
        ),
                Positioned(
                    top: 0,
                    child: Container(

/*                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  AssetImage("lib/assets/curve1.png")
                            ),
                          ),*/
                        alignment: Alignment.bottomLeft,
                        //   height: MediaQuery.of(context).size.height * .5,
                        child: Container(
                          width: 410,
                          height: 130,
                        ))),
              ],
            )),
        //   SliverToBoxAdapter(child: SizedBox(height: 200,),),
      ]),
    );
  }
}

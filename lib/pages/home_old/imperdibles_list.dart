import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/data/model/words_and_menu_images_model.dart';
import 'package:bogota_app/mock/data/testData.dart';

import 'package:bogota_app/pages/components/title_lugares.dart';
import 'package:bogota_app/pages/components/title_sec.dart';
import 'package:bogota_app/pages/components/verticalgrid.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalAndVerticalListView extends StatefulWidget {
  @override
  _HorizontalAndVerticalListViewState createState() =>
      _HorizontalAndVerticalListViewState();
}

class _HorizontalAndVerticalListViewState
    extends State<HorizontalAndVerticalListView> {
  bool state_a = true;
  bool state_b = false;
  var button_selected;
  var button_unselected;
  WordsAndMenuImagesModel dictionary = BoxDataSesion.getDictionary();

  String prevTitle = '';
  late List<String> items;
  late List<String> duplicateItems;
  late TextEditingController textController;
  late ScrollController con;
  final itemSize = 80.0;
  final g = GridVertical_Component();
  final testdata = testData();
  final stylemethod = StylesMethodsApp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setbuttonState();

    items = testdata.imgList2;
    duplicateItems = List.from(items);
    textController = TextEditingController();
    con = ScrollController();
    con.addListener(() {
      if (con.offset >= con.position.maxScrollExtent &&
          !con.position.outOfRange) {

      } else if (con.offset <= con.position.minScrollExtent &&
          !con.position.outOfRange) {

      }
    });
  }

  void _setbuttonState() {
    state_a = !state_a;
    state_b = !state_b;
    setState(() {
      if (state_a) {
        button_selected = BoxDecoration(
            gradient: LinearGradient(
              colors: IdtGradients.green,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(30.0));
      } else {
        button_unselected = BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30.0));
      }
      if (state_b) {
        button_selected = BoxDecoration(
            gradient: LinearGradient(
              colors: IdtGradients.green,
              // stops: [0.2,0.5],
              //begin: FractionalOffset.bottomCenter,
              //end: FractionalOffset.topCenter
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(30.0));
      } else {
        button_unselected = BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30.0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        Title_Lugares(),
        widget_slider_horizontal(),
        widget_row_buttons(),
        SliverToBoxAdapter(child: SizedBox(height: 20, child: Container(color: Colors.white),),),
        Title_Sec("**-IMPERDIBLE EN BOGOTÁ"),
        g.GridVertical(context, testdata.imgList2, testdata.textList2),
        widget_explorar_button(),
        Title_Sec(dictionary.appword34),
        g.GridVertical(
            context, testdata.calificadoList, testdata.textCalificadoList),
        SliverToBoxAdapter(child: SizedBox(height: 60, child: Container(color: Colors.white),),),
      ],
    );
  }

  void dispose() {
    con.dispose();
    super.dispose();
  }

  widget_slider_horizontal() => (SliverToBoxAdapter(
          child: Stack(
        // sirve para alinear las flechitas  alignment: AlignmentDirectional.topCenter,
        //  fit = StackFit.loose,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 0, top: 0),
              //  padding: EdgeInsets.only(top:1),
              height: 180,
              width: 412,
              color: Colors.white,
              child: ListView.builder(
                controller: con,
                itemCount: items.length,
                shrinkWrap: true,
                itemExtent: 150,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Column(

                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(left: 12, right: 12, top: 17),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                                topRight:
                                    Radius.circular(15.00), // FLUTTER BUG FIX
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
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    height: 200,
                                    width: 220,
                                    color: Colors.white,
                                    // margin: EdgeInsets.all(5),
                                    child: Image.network(
                                      state_a
                                          ? testdata.imgList[index]
                                          : testdata.imgList2[index],
                                      height: 200,
                                      width: 220,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            )),
                        state_a
                            ? widget_audioguias()
                            : index % 2 == 0
                                ? widget_audioguias()
                                : Container(),
                      ],
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: IdtColors.transparent,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        testdata.textList[index],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
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
              padding: const EdgeInsets.only(top: 40.0, left: 20),
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
              padding: const EdgeInsets.only(top: 40.0, left: 45),
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
                  ), onPressed: () {  },),
            ),
          )
        ],
      )));

  widget_row_buttons() => (SliverToBoxAdapter(
        child: Container(
            height: 45,
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //    height: 40.0,
                  child: RaisedButton(
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    splashColor: Colors.white,
                    onPressed: () {
                      _setbuttonState();
                      print(state_a);
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF35A466), width: 1),
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: state_a ? button_selected : button_unselected,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 150.0,
                            minWidth: 150,
                            minHeight: 50.0,
                            maxHeight: 50),
                        alignment: Alignment.center,
                        child: Text(
                          "AUDIOGUÍAS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  state_a ? Colors.white : Color(0xFF35A466)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    onPressed: () {
                      _setbuttonState();
                      print(state_b);
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF35A466), width: 1),
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: state_b ? button_selected : button_unselected,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 150.0,
                            minWidth: 150,
                            minHeight: 50.0,
                            maxHeight: 50),
                        alignment: Alignment.center,
                        child: Text(
                          "VER TODO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  state_b ? Colors.white : Color(0xFF35A466)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ));

  widget_audioguias() => (Positioned(
        top: 10.0,
        bottom: 10.0,
        left: 0.0,
        right: 0.0,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(0, 0, 0, 0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Container(
              height: 40,
              width: 85,
              decoration: BoxDecoration(
               /* image: DecorationImage(
                  image: AssetImage(IdtAssets.headphones),
                  // scale: 0.1,
                  fit: BoxFit.scaleDown,
                ),*/
              ),
              //  child: IconShadowWidget(Icon(Bogota_icon.headphones,
              //      color: Colors.white, size: 36),shadowColor: Colors.transparent,),
            ),
          ),
        ),
      ));

  widget_explorar_button()=>(
    SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        height: 110,
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(25),
                //    height: 40.0,
                child: RaisedButton(
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  onPressed: () {
                    // _setbuttonState();
                    //print(state_a);
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF50ACFF), width: 1),
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: stylemethod.decorarStyle(
                        IdtGradients.blue,
                        30,
                        Alignment.bottomCenter,
                        Alignment.topCenter),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 250.0,
                          minWidth: 180,
                          minHeight: 50.0,
                          maxHeight: 50),
                      alignment: Alignment.center,
                      child: Text(
                        "EXPLORAR BOGOTÁ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: state_a ? Colors.white : Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
  );


}

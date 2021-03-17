import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/data/testData.dart';
import 'package:bogota_app/pages/components/appbar.dart';
import 'package:bogota_app/pages/home_old/home.dart';
import 'package:bogota_app/pages/home_old/imperdibles_list.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';

class Home_User extends StatefulWidget {
  static const String routeName = "/Home_User";
  Home_User({Key? key, required this.state}) : super(key: key);
  final bool state;
  @override
  _Home_UserState createState() => _Home_UserState();
}

String assetName = 'lib/assets/logo.svg';

class _Home_UserState extends State<Home_User> {
  @override
  final a = AppBar_Component();
  final testdata = testData();
  final stylemethod = StylesMethodsApp();

  //int indexcolor= 0;
  bool indexcolor = false;
  Map<int, bool> itemsSelectedValue = Map();

  Widget svg = SvgPicture.asset(
    assetName,
    fit: BoxFit.cover,
    alignment: Alignment.center,
    height: 50.0,
    width: 100.0,
    allowDrawingOutsideViewBox: true,
  );

  var withoutcolor;
  var gradientcolor;
  void initState() {
    // TODO: implement initState
    super.initState();
    withoutcolor = BoxDecoration(
      borderRadius: BorderRadius.circular(60),
      color: Colors.transparent,
    );

    gradientcolor = stylemethod.decorarStyle(IdtGradients.orange, 40,
        Alignment.topCenter, Alignment.bottomCenter);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar_Component(
          state_profile: widget.state,
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: widget.state ? 0.05 : 1, //0.05,
              child: Container(
                child: Center(child: HorizontalAndVerticalListView()),
              ),
            ),
            //  Positioned(child: menuVertical())
            widget.state
                ? Positioned(child: menuVertical(context))
                : Container()
          ],
        ));
  }

  Widget menuVertical(context) => (SingleChildScrollView(
    physics: ScrollPhysics(),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
              size: 35,
            ),
            onPressed: () {
              // Navigator.pushNamed(context, Home().routeName);
              Navigator.of(context).pushReplacementNamed('/HomePage');
            }),
        ),
        SizedBox(
          height: 15,
        ),
        widget_profile(),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          //   itemExtent: 50,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          itemCount: testdata.List2.length,
          itemBuilder: (BuildContext context, int index) {
            bool isCurrentIndexSelected =
            (itemsSelectedValue[index] == null
                ? false
                : itemsSelectedValue[index])!;
            //     bool isCurrentIndexSelected = false;
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  print("${isCurrentIndexSelected}");
                  setState(() {
                    itemsSelectedValue[index] = !isCurrentIndexSelected;
                    print(
                        "OnClick : $index + ${itemsSelectedValue[index]}");
                    indexcolor = !indexcolor;
                  });
                  //if (index==3 ){Navigator.pushNamed(context, Mas_Alla.routeName);}
                  print(index);
                  if (index == 3) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                              state: false,
                              i: 3,
                              newscreen: true,
                            )));
                  }
                  if (index == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                              state: false,
                              i: 2,
                              newscreen: true,
                            )));
                  }
                  if (index == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(
                              state: false,
                              i: 1,
                              newscreen: true,
                            )));
                  }
                  // Navigator.pushNamed(context, Profile.routeName, arguments: Profile(state: true,),);
                  // if(index==2){Navigator.pushNamed(context, Home.routeName, arguments: Home(state: false,i: 1, newscreen: true,),);}

                  //    if (index==2 ) {Navigator.pushNamed(context, Imperdibles.routeName);}
                  //     if (index==1 ) {Navigator.pushNamed(context, Audioguias.routeName);}
                },
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.05,
                      child: Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.all(10),
                        height: 30.0,
                        // child:
                      ),
                    ),
                    //    index==1? color_button:Container(),
                    Positioned(
                      top: 1,
                      //   left:180,

                      child: isCurrentIndexSelected
                          ? Listener(
                        // onTap: () => {print(index)},

                        child: Container(
                            margin: EdgeInsets.all(10),
                            height: 35.0,
                            width: MediaQuery.of(context).size.width *
                                0.9,
                            decoration: !indexcolor
                                ? withoutcolor
                                : gradientcolor,

                            // constraints:  BoxConstraints(maxWidth: 400.0, minWidth: 400, minHeight: 50.0, maxHeight: 50),
                            alignment: Alignment.center,
                            child: Text(' ${testdata.List2[index]}',
                                style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    fontWeight: !indexcolor
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                    color: !indexcolor
                                        ? Color(0xFF505050)
                                        : Colors.white,
                                    fontSize: 18))),
                        onPointerDown: (_) {
                          setState(() {
                            print("aqui");
                            print("${!isCurrentIndexSelected}");
                            //  itemsSelectedValue[index] = !isCurrentIndexSelected;
                            indexcolor = !indexcolor;
                          });
                        },
                        onPointerUp: (_) {
                          setState(() {
                            //     itemsSelectedValue[index] = !isCurrentIndexSelected;
                            indexcolor = !indexcolor;
                          });
                        },
                      )
                          : Container(
                          margin: EdgeInsets.all(10),
                          height: 30.0,
                          width:
                          MediaQuery.of(context).size.width * 0.9,
                          // decoration: indexcolor==0?withoutcolor:gradientcolor,

                          // constraints:  BoxConstraints(maxWidth: 400.0, minWidth: 400, minHeight: 50.0, maxHeight: 50),
                          alignment: Alignment.center,
                          child: Text(' ${testdata.List2[index]}',
                              style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF505050),
                                  fontSize: 18))),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, posicion) {
            return Container(height: 1,);
          },
        ),
      ],
    ),
  ));

  widget_profile()=>(
      Container(
        // color: Colors.green,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, right: 30, left: 30, bottom: 5),
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundImage: NetworkImage(
                            'https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 165,
                      child: Container(
                        child: Icon(
                          IdtIcons.engrane,
                          size: 27,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ))
  );
}

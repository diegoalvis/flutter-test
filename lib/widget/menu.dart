import 'package:bogota_app/bogota_icon.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class IdtMenu extends StatelessWidget {

  final VoidCallback closeMenu;

  IdtMenu({required this.closeMenu});

  final _route = locator<IdtRoute>();

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    bool indexcolor = false;
    Map<int, bool> itemsSelectedValue = Map();
    var withoutcolor;
    var gradientcolor;

    widget_profile() => (
      Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 30, left: 30, bottom: 5),
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundImage: NetworkImage(
                        'https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg'
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 17,
                    left: 165,
                    child: Container(
                      child: Icon(
                        Bogota_icon.engrane,
                        size: 27,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      )
    );

    return SingleChildScrollView(
      child: Container(
        /*width: double.infinity,
        height: double.infinity,*/
        decoration: BoxDecoration(
          color: IdtColors.white.withOpacity(0.95),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: IdtColors.orange,
                  size: 35,
                ),
                onPressed: closeMenu
              ),
            ),
            SizedBox(
              height: 15,
            ),
            widget_profile(),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              itemCount: DataTest.List2.length,
              itemBuilder: (BuildContext context, int index) {
                bool isCurrentIndexSelected =
                (itemsSelectedValue[index] == null ? false : itemsSelectedValue[index])!;

                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {

                      switch(index) {
                        case 0: {
                          _route.goDiscover();
                        }
                        break;

                        case 1: {
                          _route.goAudioGuide();
                        }
                        break;

                        case 2: {
                          _route.goUnmissable();
                        }
                        break;

                        case 4: {
                          _route.goEvents(title: 'Eventos', includeDay: true);
                        }
                        break;

                        case 5: {
                          _route.goEvents(title: 'Dónde dormir', includeDay: false, nameFilter: 'Localidad');
                        }
                        break;

                        case 6: {
                          _route.goFilters('Gastronomía');
                        }
                        break;

                        case 7: {
                          _route.goSavedPlaces();
                        }
                        break;

                        default: {
                          //statements;
                        }
                        break;
                      }
                      closeMenu();
                    },
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.05,
                          child: Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.all(10),
                            height: 30.0,
                          ),
                        ),
                        //    index==1? color_button:Container(),
                        Positioned(
                          top: 1,
                          child: isCurrentIndexSelected
                              ? Listener(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 35.0,
                              width: MediaQuery.of(context).size.width *
                                  0.9,
                              decoration: !indexcolor ? withoutcolor : gradientcolor,
                              alignment: Alignment.center,
                              child: Text(' ${DataTest.List2[index]}',
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  fontWeight: !indexcolor ? FontWeight.normal : FontWeight.bold,
                                  color: !indexcolor ? Color(0xFF505050) : Colors.white,
                                  fontSize: 18
                                )
                              )
                            ),
                            onPointerDown: (_) {
                              /*setState(() {
                                print("aqui");
                                print("${!isCurrentIndexSelected}");
                                //  itemsSelectedValue[index] = !isCurrentIndexSelected;
                                indexcolor = !indexcolor;
                              });*/
                            },
                            onPointerUp: (_) {
                              /*setState(() {
                                //     itemsSelectedValue[index] = !isCurrentIndexSelected;
                                indexcolor = !indexcolor;
                              });*/
                            },
                          )
                          : Container(
                            margin: EdgeInsets.all(10),
                            height: 30.0,
                            width: MediaQuery.of(context).size.width * 0.9,
                            alignment: Alignment.center,
                            child: Text(
                              ' ${DataTest.List2[index]}',
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF505050),
                                fontSize: 18
                              )
                            )
                          ),
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
            SizedBox(
              height: 65,
            ),
          ],
        ),
      ),
    );
  }
}
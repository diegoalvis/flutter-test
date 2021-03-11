import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
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
                    top: 5,
                    right: 2,
                    child: Container(
                      child: IconButton(
                        onPressed: _route.goProfile,
                        icon: Icon(
                          IdtIcons.engrane,
                          size: 27,
                        ),
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

                        case 3: {
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
                            color: IdtColors.transparent,
                            margin: EdgeInsets.all(10),
                            height: 30.0,
                          ),
                        ),
                        Positioned(
                          top: 1,
                          right: 5,
                          left: 5,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 30.0,
                            alignment: Alignment.center,
                            child: Text(
                              ' ${DataTest.List2[index]}',
                              style: textTheme.textMenu.copyWith(
                                color: IdtColors.gray.withOpacity(0.8),
                                fontSize: 19
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
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
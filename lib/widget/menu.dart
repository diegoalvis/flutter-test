import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class IdtMenu extends StatelessWidget {
  final VoidCallback closeMenu;
  final int? optionIndex;

  IdtMenu({required this.closeMenu, this.optionIndex});

  final _route = locator<IdtRoute>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final profileWidget = (Container(
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
                  backgroundImage: AssetImage(IdtAssets.profile_photo),
/*                      NetworkImage(
                          'https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg'),*/
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: 5,
                right: 2,
                child: Container(
                  child: IconButton(
                    onPressed: () async {
                      await _route.goProfile();
                      closeMenu();
                    },
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
    )));

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
                  onPressed: closeMenu),
            ),
            SizedBox(
              height: 15,
            ),
            profileWidget,
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
                      onOptionSelected(index);
                    },
                    child: Stack(
                      children: [
                        optionIndex == index
                            ? Container(
                                decoration: StylesMethodsApp().decorarStyle(IdtGradients.orange, 30,
                                    Alignment.bottomCenter, Alignment.topCenter),
                                margin: EdgeInsets.all(10),
                                height: 30.0,
                              )
                            : Container(
                                color: IdtColors.transparent,
                                margin: EdgeInsets.all(10),
                                height: 30.0,
                              ),
                        Positioned(
                          top: 1,
                          right: 5,
                          left: 5,
                          child: Container(
                              margin: EdgeInsets.all(10),
                              height: 30.0,
                              alignment: Alignment.center,
                              child: Text(' ${DataTest.List2[index]}',
                                  style: textTheme.textMenu.copyWith(
                                    // fontSize: 19,
                                    color: optionIndex == index
                                        ? IdtColors.white.withOpacity(0.8)
                                        : IdtColors.gray.withOpacity(0.8),
                                  ))),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, posicion) {
                return Container(
                  height: 1,
                );
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

  void onOptionSelected(int index) {
    switch (index) {
      case 0:
        _route.goDiscoverUntil();
        break;
      case 1:
        _route.goAudioGuide(index);
        break;
      case 2:
        _route.goUnmissableUntil(index);
        break;
      case 3:
        _route.goHomeRemoveAll();
        break;
      case 4:
        _route.goEvents(index);
        break;
      case 5:
        _route.goSleeps(index);
        break;
      case 6:
        _route.goEat(index);
        break;
      case 7:
        _route.goSavedPlacesUntil();
        break;
      default:
        //statements;
        break;
    }
    closeMenu();
  }
}



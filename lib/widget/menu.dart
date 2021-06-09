import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app_theme.dart';

class IdtMenu extends StatelessWidget {
  final VoidCallback closeMenu;
  final int? optionIndex;

  IdtMenu({required this.closeMenu, this.optionIndex});

  final _route = locator<IdtRoute>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final String imageUrl = '';
    // 'https://www.batiburrillo.net/wp-content/uploads/2019/07/Ampliacio%CC%81n-de-imagen-en-li%CC%81nea-sin-perder-calidad.jpg';

    Future<String> getNameUser() async {
      //TODO
      final Person? person = await BoxDataSesion.getFromBox();
      return person!.name.toString();
    }

    profileWidget(BuildContext context) =>
        (Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, right: 30, left: 30, bottom: 5),
                        child: FutureBuilder(
                          future: getNameUser(),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (!snapshot.hasData) {
                              // while data is loading:
                              print(snapshot);
                              return Center(
                                child: CircleAvatar(
                                  foregroundColor: IdtColors.white,
                                  backgroundColor: IdtColors.blue,
                                  radius: 70.0,
                                  /*                      NetworkImage(
                            'https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg'),*/
                                ),
                              );
                            } else {
                              print(snapshot);
                              return CircleAvatar(
                                  foregroundColor: IdtColors.white,
                                  backgroundColor: IdtColors.blue,
                                  backgroundImage: imageUrl.isNotEmpty
                                      ? NetworkImage(imageUrl)
                                      : null,
                                  radius: 70.0,
                                  child: imageUrl.isEmpty
                                      ? Text(
                                    snapshot.data.toString()[0].toUpperCase(),
                                    style: TextStyle(fontSize: 50),
                                  )
                                      : SizedBox.shrink()
/*                      NetworkImage(
                            'https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg'),*/
                              );
                        }
                      },
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

    final listMenu = DataTest.List2(BoxDataSesion.isLoggedIn);
    return SingleChildScrollView(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 2000),
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
              profileWidget(context),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(8),
                itemCount: listMenu.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        onOptionSelected(listMenu[index], index);
                      },
                      child: Stack(
                        children: [
                          optionIndex == index
                              ? Container(
                                  decoration: StylesMethodsApp().decorarStyle(
                                      IdtGradients.orange,
                                      30,
                                      Alignment.bottomCenter,
                                      Alignment.topCenter),
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
                                child: Text(' ${listMenu[index]['title']}',
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
      ),
    );
  }

  void onOptionSelected(Map<String, dynamic> item, int index) {
    switch (item['value']) {
      case 'login':
        _route.goLogin();
        break;
      case 'discoverUntil':
        _route.goDiscoverUntil();
        break;
      case 'audioGuide':
        _route.goAudioGuide();
        break;
      case 'unmissableUntil':
        _route.goUnmissableUntil(index);
        break;
      // case 3:
      //   _route.goHomeRemoveAll();
      //   break;
      case 'events':
        _route.goEvents(index);
        break;
      case 'sleeps':
        _route.goSleeps(index);
        break;
      case 'eat':
        _route.goEat(index);
        break;
      case 'savedPlacesUntil':
        _route.goSavedPlacesUntil();
        break;
      case 'savedPlacesUntil':
        _route.goPrivacyAndTerms();
        break;
      default:
        //statements;
        break;
    }
    closeMenu();
  }
}

import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app_theme.dart';
import 'NFMarquee.dart';
import 'carouselLanguages.dart';

class IdtMenu extends StatelessWidget {
  final VoidCallback closeMenu;
  final String? optionIndex;

  IdtMenu({required this.closeMenu, this.optionIndex});

  final _route = locator<IdtRoute>();

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final String imageUrl = '';
    // 'https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg';

    Future<String> getNameUser() async {
      //TODO
      CurrentUser user = BoxDataSesion.getCurrentUser()!;

      final Person? person = await BoxDataSesion.getFromBox(user.id_db!);
      return person!.name.toString();
    }

    profileWidget(BuildContext context) => (Container(
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
                              foregroundColor: Colors.white,
                              backgroundColor: IdtColors.blue,
                              radius: 70.0,
                              child: Icon(
                                Icons.person,
                                size: 70,
                              ),
                              /*                      NetworkImage(
                            'https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg'),*/
                            ),
                          );
                        } else {
                          print(snapshot);
                          return CircleAvatar(
                              foregroundColor: IdtColors.white,
                              backgroundColor: IdtColors.blue,
                              backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                              radius: 70.0,
                              child: imageUrl.isEmpty
                                  ? Text(
                                      snapshot.data.toString()[0].toUpperCase(),
                                      style: TextStyle(fontSize: 50),
                                    )
                                  : SizedBox.shrink());
                        }
                      },
                    ),
                  ),
                  BoxDataSesion.isLoggedIn
                      ? Positioned(
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
                      : SizedBox.shrink()
                ],
              )
            ],
          ),
        )));

    final listMenu = DataTest.List2(BoxDataSesion.isLoggedIn);
    int? typeLanguage = 0;
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
              SizedBox(
                height: 25,
              ),
              Container(
                width: sizeScreen.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child: Stack(
                    children: [
                      CarouselLanguages(sizeScreen: sizeScreen, typeLanguage: typeLanguage, selectColor: IdtColors.orange,),
                      Container(
                        width: 12.0,
                        height: 40,
                        decoration: BoxDecoration(

                          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),  topLeft: Radius.circular(100)),
                          // color: Colors.red,
                          gradient: LinearGradient(
                            colors: <Color>[IdtColors.white.withOpacity(0.8),IdtColors.white.withOpacity(0.6),IdtColors.white.withOpacity(0.3),IdtColors.white.withOpacity(0.1) ],
                            // red to yellow
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 12.0,
                          height: 40,
                          decoration: BoxDecoration(

                            // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),  topLeft: Radius.circular(100)),
                            // color: Colors.red,
                            gradient: LinearGradient(
                              colors: <Color>[
                                IdtColors.white.withOpacity(0.1) ,
                                IdtColors.white.withOpacity(0.3),
                                IdtColors.white.withOpacity(0.6),
                                IdtColors.white.withOpacity(0.8),
                              ],
                              // red to yellow
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                          optionIndex == listMenu[index]['title']
                              ? Container(
                                  decoration: StylesMethodsApp().decorarStyle(IdtGradients.orange,
                                      30, Alignment.bottomCenter, Alignment.topCenter),
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
                              child: AutoSizeText(
                                '${listMenu[index]['title']}',
                                style: textTheme.textMenu.copyWith(
                                  color: optionIndex == listMenu[index]['title']
                                      ? IdtColors.white.withOpacity(0.8)
                                      : IdtColors.gray.withOpacity(0.8),
                                ),
                                maxLines: 1,
                                maxFontSize: 19,
                                minFontSize: 16,
                              ),
                            ),
                          ),
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
      case 'privacyAndTerms':
        _route.goPrivacyAndTerms();
        break;
      default:
        //statements;
        break;
    }
    closeMenu();
  }
}

import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/extensions/language.dart';

class CarouselLanguages extends StatefulWidget {
  CarouselLanguages(
      this.buttonEnable,
      {Key? key,
      required this.selectColor,
      required this.sizeScreen,
      required this.languages})
      : super(key: key);

  final VoidCallback buttonEnable;
  final Color selectColor;
  final Size sizeScreen;
  List<LanguageModel> languages;

  @override
  _CarouselLanguagesState createState() => _CarouselLanguagesState();
}

class _CarouselLanguagesState extends State<CarouselLanguages> {
  int? typeLanguage;

  Widget build(BuildContext context) {
    readSelectedLanguaje();
    return Container(
      width: widget.sizeScreen.width * 0.7,
      height: 70,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 110),
          scrollDirection: Axis.horizontal,
          itemCount: widget.languages.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  widget.buttonEnable();
                  print('Idioma selecionando index: $index');
                  print(widget.languages[index].prefix);

                  typeLanguage = index;
                  savedSelectedLanguaje(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(
                      width: 5,
                      color: typeLanguage == index ? widget.selectColor : Colors.transparent,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75.0),
                    child: Flag.fromCode(
                      // testData.listFlags[index],
                      widget.languages.elementAt(index).toFlagCode(),
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 20,
            );
          }),
    );
  }

  void savedSelectedLanguaje(int index) {
    CurrentUser? user = BoxDataSesion.getCurrentUser();
    /*
      Revisar estos dos id, no se cual es el id del usuario
      user?.id_user o user?.user?.id_db no se cual es
    */
    BoxDataSesion.pushToLanguaje(user?.id_user, widget.languages[index].prefix!);
  }

  void readSelectedLanguaje() {
    CurrentUser? user = BoxDataSesion.getCurrentUser();
    String prefixLanguaje = BoxDataSesion.getLanguajeByUser(idUser: user?.id_user);
    print('Lenguaje recuperado $prefixLanguaje para ${user?.id_user}');
    // return prefixLanguaje;
  }
}

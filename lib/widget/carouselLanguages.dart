import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/extensions/language.dart';

class CarouselLanguages extends StatefulWidget {
  CarouselLanguages(this.buttonEnable,
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
  Widget build(BuildContext context) {
    String? lanSelected  =  readSelectedLanguaje();
    return Container(
      width: widget.sizeScreen.width * 0.7,
      height: 70,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 110),
          scrollDirection: Axis.horizontal,
          itemCount: widget.languages.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  savedSelectedLanguaje(index);
                  widget.buttonEnable();
                  print('Idioma selecionando index: $index');
                  setState(() {
                    lanSelected = widget.languages.elementAt(index).prefix;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(
                      width: 5,
                      color: lanSelected == widget.languages.elementAt(index).prefix ? widget.selectColor : Colors.transparent,
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
    /*
      Revisar estos dos id, no se cual es el id del usuario
      user?.id_user o user?.user?.id_db no se cual es
    */
    String prefix =  widget.languages[index].prefix!;
    BoxDataSesion.pushToLaguageUser(prefix);
  }

  String readSelectedLanguaje() {
    String prefixLanguaje = BoxDataSesion.getLaguageByUser();
    return prefixLanguaje;
  }
}

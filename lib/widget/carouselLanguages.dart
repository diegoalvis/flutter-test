import 'package:bogota_app/data/model/language_model.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/mock/data/testData.dart';
import 'package:bogota_app/extensions/language.dart';

class CarouselLanguages extends StatefulWidget {
  CarouselLanguages(
      {Key? key,
      required this.selectColor,
      required this.sizeScreen,
      required this.typeLanguage,
      required this.languages})
      : super(key: key);

  final Color selectColor;
  final Size sizeScreen;
  int? typeLanguage;
  List<LanguageModel> languages;

  @override
  _CarouselLanguagesState createState() => _CarouselLanguagesState();
}

class _CarouselLanguagesState extends State<CarouselLanguages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.sizeScreen.width * 0.7,
      height: 70,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 110),
          scrollDirection: Axis.horizontal,
          itemCount: widget.languages!.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              // Print('${viewModel.saveLanguajes}')
              print('Idioma selecionando index: $index');
              print(widget.languages[index].name);
              setState(() {
                widget.typeLanguage = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                border: Border.all(
                  width: 5,
                  color:
                      widget.typeLanguage == index ? widget.selectColor : Colors.transparent,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75.0),
                child: Flag.fromCode(
                  // testData.listFlags[index],
                  widget.languages.elementAt(index)?.toFlagCode() ?? FlagsCode.CO,
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
}

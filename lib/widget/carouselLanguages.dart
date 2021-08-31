import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/mock/data/testData.dart';

class CarouselLanguages extends StatelessWidget {

  CarouselLanguages({
    Key? key,
    required this.selectColor,
    required this.sizeScreen,
    required this.typeLanguage,
  }) : super(key: key);

  final Color selectColor;
  final Size sizeScreen;
  int? typeLanguage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeScreen.width * 0.7,
      height: 70,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 110),
          scrollDirection: Axis.horizontal,
          itemCount: testData.listFlags.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              print('Idimoa selecionando index: $index');
              // setState(() {
              typeLanguage = index;
              // });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                border: Border.all(
                  width: 5,
                  color: typeLanguage == index
                      ? selectColor
                      : Colors.transparent,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75.0),
                child: Flag.fromCode(
                  testData.listFlags[index],
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

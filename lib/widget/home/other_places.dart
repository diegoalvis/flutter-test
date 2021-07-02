import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/pages/home/home_view_model.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../app_theme.dart';

class OtherPlaces extends StatelessWidget {
  final Function(String) onTapCard;
  final VoidCallback goDiscover;
  late List<DataModel>? resUnmissable;
  late List<DataModel>? resFood;
  late List<DataModel>? bestRated;

  OtherPlaces({required this.onTapCard, required this.goDiscover, this.resUnmissable, this.resFood, this.bestRated});


  Widget ImagesCard(
          TextTheme textTheme, String item, int index, List res, String name, DataModel valueData) =>
      (Center(
        child: InkWell(
         // onTap: onTapCard,
        //  onTap: () => print("en ontap"),
          onTap: () => onTapCard(valueData.id.toString()),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: (index == 0)
                    ? BorderRadius.only(topLeft: Radius.circular(15))
                    : (index == 1)
                        ? BorderRadius.only(topRight: Radius.circular(15))
                        : (index == (res.length - 2) && index % 2 == 0)
                            ? BorderRadius.only(bottomLeft: Radius.circular(15))
                            : (index == (res.length - 1) && index % 2 != 0)
                                ? BorderRadius.only(
                                    bottomRight: Radius.circular(15))
                                : BorderRadius.circular(0.0),
                child: SizedBox(
                  child: Image.network(
                    item,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: AutoSizeText(
                    name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    minFontSize: 11,
                    maxFontSize: 12,
                    style: textTheme.textWhiteShadow,
                  )
                  // Text(
                  //   name,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   textAlign: TextAlign.center,
                  //   style: textTheme.textWhiteShadow,
                  // ),
                ),
              ),
            ],
          ),
        ),
      ));

  Widget GridImagesCol2(TextTheme textTheme, List<DataModel> listItems) =>
      (GridView.count(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        //childAspectRatio: 7/6,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: listItems.asMap().entries.map((entry) {
          final int index = entry.key;
          final imageUrl = entry.value.image!;
          final String value = IdtConstants.url_image + imageUrl;
          final String namePlace = entry.value.title!;
          final DataModel valueData = entry.value;
          return ImagesCard(textTheme, value, index, listItems, namePlace, valueData);
        }).toList(),
      ));

  best_rated_btn(TextTheme textTheme) => (Container(
        margin: EdgeInsets.all(25),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: IdtColors.blue, width: 1),
              borderRadius: BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(0.0),
          child: Container(
              constraints: BoxConstraints(
                  maxWidth: 250.0,
                  minWidth: 180,
                  minHeight: 50.0,
                  maxHeight: 50),
              decoration: StylesMethodsApp().decorarStyle(IdtGradients.blue, 30,
                  Alignment.bottomCenter, Alignment.topCenter),
              alignment: Alignment.center,
              child: Text(
                'DESCUBRE BOGOTÁ',
                textAlign: TextAlign.center,
                style: textTheme.textButtomWhite,
              )),
          onPressed: goDiscover,
        ),
      ));

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(height: 35),
        TitleSection('Imperdible en Bogotá'),
        SizedBox(height: 25),
        GridImagesCol2(textTheme, resUnmissable!),
        SizedBox(height: 5),
        best_rated_btn(textTheme),
        SizedBox(height: 20),
        TitleSection('Mejor calificado'),
        SizedBox(height: 15),
        GridImagesCol2(textTheme, bestRated!),
        SizedBox(height: 55),
      ],
    );
  }
}

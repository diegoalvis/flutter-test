import 'dart:async';
import 'dart:core';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_theme.dart';

class SavedPlaces extends StatelessWidget {

  final bool openSaved;
  final VoidCallback changeSaved;
  final bool notSaved;
  final VoidCallback addSaved;
  final bool seeAll;
  final Function(bool) onTapSeeAll;
  final Function(bool) changeSrollController;
  final ScrollController scrollController;
  final VoidCallback onTapCard;

  SavedPlaces(this.openSaved, this.changeSaved, this.notSaved, this.addSaved, this.seeAll,
      this.onTapSeeAll, this.changeSrollController, this.scrollController, this.onTapCard);

  Widget imagesCard(String image, int index, List<bool> listGuide) => (

    Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 1),
      color: IdtColors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15)
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: IdtColors.blackShadow,
            offset: Offset(0, 0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                listGuide[index] ? IdtColors.black : IdtColors.transparent,
                BlendMode.difference
              ),
              child: Image.network(
                image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          listGuide[index] ? Icon(
            IdtIcons.headphones,
            color: IdtColors.white,
            size: 50,
          ) : SizedBox.shrink()
        ],
      ),
    )
  );

  Widget SliderImages(BuildContext context, TextTheme textTheme, List<bool> listGuide, List<String> listImages, List<String> listText) =>

    InkWell(
      onTap: onTapCard,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 220,
            margin: EdgeInsets.only(top: 10),
            color: IdtColors.white,
            child: ListView.builder(
              controller: scrollController,
              itemCount: listImages.length,
              itemExtent: 155,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  imagesCard(listImages[index], index, listGuide),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Text(
                      listText[index],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: textTheme.grayDetail.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          Positioned(
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50, left: 5),
              child: IconButton(
                iconSize: 45,
                alignment: Alignment.centerLeft,
                icon: Icon(
                  Icons.play_circle_fill,
                  color: IdtColors.white,
                ),
                onPressed: () => changeSrollController(false),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50, right: 5),
              child: IconButton(
                iconSize: 45,
                alignment: Alignment.centerRight,
                icon: Icon(
                  Icons.play_circle_fill,
                  color: IdtColors.white,
                ),
                onPressed: () => changeSrollController(true),
              ),
            ),
          ),
        ],
      )
    );

  widget_row_buttons(TextTheme textTheme) => (
    Container(
      height: 45,
      color: IdtColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ignore: deprecated_member_use
          RaisedButton(
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            onPressed: () => onTapSeeAll(false),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: IdtColors.greenDark,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(80.0)
            ),
            padding: EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: seeAll ? null : LinearGradient(
                  colors: IdtGradients.green,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                color: IdtColors.white,
                borderRadius: BorderRadius.circular(30.0)
              ),
              constraints: BoxConstraints(
                maxWidth: 150.0,
                minWidth: 150,
                minHeight: 50.0,
                maxHeight: 50
              ),
              alignment: Alignment.center,
              child: Text(
                'AUDIOGUÍAS',
                textAlign: TextAlign.center,
                style: textTheme.textButtomWhite.copyWith(
                  color: seeAll ? IdtColors.greenDark : null
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            onPressed: () => onTapSeeAll(true),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: IdtColors.greenDark,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(80.0)
            ),
            padding: EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: seeAll ? LinearGradient(
                  colors: IdtGradients.green,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ) : null,
                color: IdtColors.white,
                borderRadius: BorderRadius.circular(30.0)
              ),
              constraints: BoxConstraints(
                maxWidth: 150.0,
                minWidth: 150,
                minHeight: 50.0,
                maxHeight: 50
              ),
              alignment: Alignment.center,
              child: Text(
                'VER TODOS',
                textAlign: TextAlign.center,
                style: textTheme.textButtomWhite.copyWith(
                  color: seeAll ? null : IdtColors.greenDark
                ),
              ),
            ),
          ),
        ],
      )
    )
  );

  Widget _notSavedPlaces(){

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: IdtColors.grayBg
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: IdtColors.gray,
                size: 80
              ),
              onPressed: addSaved,
            ),
          ),
        ),
      ],
    );
  }

  Widget _textTitle(TextTheme textTheme) {

    return Row(
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              TitleSection('LUGARES GUARDADOS'),
              Positioned(
                right: 12,
                child: IconButton(
                  color: IdtColors.transparent,
                  alignment: Alignment.center,
                  icon: SvgPicture.asset(
                    IdtAssets.minus,
                    height: 30,
                  ),
                  onPressed: changeSaved,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(height: 35),
        _textTitle(textTheme),
        openSaved ? Column(
          children: [
            SizedBox(height: 12),
            notSaved ? _notSavedPlaces() : Column(
              children: [
                SliderImages(
                  context,
                  textTheme,
                  seeAll ? DataTest.boolList : DataTest.boolListAudio,
                  seeAll ? DataTest.imgList : DataTest.imgListAudio,
                  seeAll ? DataTest.textList : DataTest.textListAudio,
                ),
                widget_row_buttons(textTheme),
              ],
            ),
          ],
        ) : SizedBox.shrink(),
      ],
    );
  }
}

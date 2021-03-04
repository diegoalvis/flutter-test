import 'dart:core';

import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:bogota_app/pages/components/gradientIcon.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/material.dart';

import '../../app_theme.dart';

class SavedPlaces extends StatefulWidget {

  SavedPlaces();

  @override
  _SavedPlacesState createState() => _SavedPlacesState();
}

class _SavedPlacesState extends State<SavedPlaces> {

  final scrollController = ScrollController();
  final itemSize = 80.0;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
      } else if (scrollController.offset <= scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
      }
    });
    super.initState();
  }

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget SliderImages(BuildContext context) => (
    Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 0, top: 0),
          height: 180,
          color: IdtColors.white,
          child: ListView.builder(
            controller: scrollController,
            itemCount: DataTest.imgList2.length,
            itemExtent: 150,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12, top: 17),
                      decoration: BoxDecoration(
                        color: IdtColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0)
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[600],
                            offset: Offset(0, 0),
                            blurRadius: 11.0,
                          ),
                        ],
                      ),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              height: 200,
                              width: 220,
                              color: Colors.white,
                              child: Image.network(
                                DataTest.imgList[index],
                                height: 200,
                                width: 220,
                                fit: BoxFit.cover,
                              ),
                            )),
                      )
                    )
                  ],
                ),

                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: IdtColors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    DataTest.textList[index],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: IdtColors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
            //  itemCount: imgList.length
          )
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.98,
          right: MediaQuery.of(context).size.width * 0.08,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20),
            child: IconButton(
              iconSize: 35,
              alignment: Alignment.centerLeft,
              icon: FittedBox(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.grey[900],
                  ),
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset - itemSize,
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 500)
                    );
                  },
                ),
              )
            ),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.98,
          left: MediaQuery.of(context).size.width * 0.74,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 45),
            child: IconButton(
              iconSize: 35,
              alignment: Alignment.centerLeft,
              icon: FittedBox(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[900],
                  ),
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset + itemSize,
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 500)
                    );
                  },
                ),
              )
            ),
          ),
        )
      ],
    )
  );

  widget_row_buttons() => (
    Container(
      height: 45,
      margin: EdgeInsets.only(top: 10),
      color: IdtColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: RaisedButton(
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              splashColor: IdtColors.white,
              onPressed: () {
                print('Test');
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFF35A466), width: 1),
                borderRadius: BorderRadius.circular(80.0)
              ),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  /*gradient: LinearGradient(
                    colors: IdtStyles.greengradientcolor,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),*/
                  color: IdtColors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: 150.0,
                      minWidth: 150,
                      minHeight: 50.0,
                      maxHeight: 50),
                  alignment: Alignment.center,
                  child: Text(
                    'AUDIOGUÍAS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF35A466)
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 50.0,
            child: RaisedButton(
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              onPressed: () {
                print('Test');
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFF35A466), width: 1),
                borderRadius: BorderRadius.circular(80.0)
              ),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: IdtGradients.green,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Container(
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
                    style: TextStyle(
                      color: IdtColors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )));

  Widget _textTitle(TextTheme textTheme) {

    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: [
              TitleSection('LUGARES GUARDADOS'),
              Positioned(
                right: 12,
                child: IconButton(
                  color: IdtColors.transparent,
                  alignment: Alignment.center,
                  icon: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: IdtGradients.green,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(100.0)
                    ),
                    child: Container(
                      child: GradientIcon(
                          icon: Icons.remove,
                          size: 25.0,
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.white,
                              Colors.white,
                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                      ),
                    ),
                  ),
                  onPressed: () {
                  },
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
        SizedBox(height: 12),
        SliderImages(context),
        SizedBox(height: 10),
        widget_row_buttons(),
      ],
    );
  }
}

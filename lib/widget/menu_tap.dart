import 'package:bogota_app/commons/idt_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class IdtMenuTap extends StatelessWidget {

  final VoidCallback closeMenu;
  final VoidCallback goFilters;
  final List listItems;
  final bool isBlue;
  /*final Color colorBack;
  final double opacity;*/

  IdtMenuTap({
    required this.closeMenu,
    required this.listItems,
    required this.goFilters,
    this.isBlue = false,
    /*this.colorBack = IdtColors.white,
    this.opacity = 0.95*/
  });

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: isBlue ? 168 : 150),
      color: IdtColors.white.withOpacity(0.95),
      child: Container(
        color: isBlue ? IdtColors.blue.withOpacity(0.15) : IdtColors.transparent,
        height: double.infinity,
        child: _buildBody(textTheme)),
    );
  }

  SingleChildScrollView _buildBody(TextTheme textTheme) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
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
              onPressed: closeMenu
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8),
            itemCount: listItems.length,
            itemBuilder: (BuildContext context, int index) {

              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: goFilters,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 30.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    child: Text(
                      ' ${listItems[index]}',
                      style: textTheme.textMenu.copyWith(
                          color: isBlue ? IdtColors.blueAccent : null
                      )
                    )
                  ),
                ),
              );
            },
            separatorBuilder: (context, posicion) {
              return Container(height: 1,);
            },
          ),
        ],
      ),
    );
  }
}
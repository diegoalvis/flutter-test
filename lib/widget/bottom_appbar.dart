import 'package:bogota_app/bogota_icon.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IdtBottomAppBar extends StatelessWidget {

  final VoidCallback? goDiscover;
  final VoidCallback? goSearch;
  final bool discoverSelect;
  final bool searchSelect;

  IdtBottomAppBar({this.goDiscover, this.goSearch, this.discoverSelect = true, this.searchSelect = false});

  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 7,
      child: Container(
        height: 52,
        child: Row(
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(
                  Bogota_icon.compass,
                  color: discoverSelect ? IdtColors.orange : IdtColors.grayBtn,
                  size: 32
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
                onPressed: goDiscover
              ),
            ),
            Container(
              color: IdtColors.grayBtn,
              width: 2,
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: searchSelect ? IdtColors.orange : IdtColors.grayBtn,
                  size: 38
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
                onPressed: goSearch
              ),
            )
          ],
        ),
      )
    );
  }
}
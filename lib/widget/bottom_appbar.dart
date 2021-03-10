import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IdtBottomAppBar extends StatelessWidget {

  final bool discoverSelect;
  final bool searchSelect;

  IdtBottomAppBar({this.discoverSelect = true, this.searchSelect = false});

  final _route = locator<IdtRoute>();

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
                  IdtIcons.compass,
                  color: discoverSelect ? IdtColors.orange : IdtColors.grayBtn,
                  size: 32
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
                onPressed: _route.goDiscoverUntil
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
                onPressed: _route.goSearchUntil
              ),
            )
          ],
        ),
      )
    );
  }
}
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:flutter/material.dart';

class IdtFab extends StatelessWidget {

  final bool homeSelect;

  IdtFab({this.homeSelect = false});

  @override
  Widget build(BuildContext context) {

    final homeSelected = BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: homeSelect ? IdtGradients.orange : IdtGradients.white
      )
    );


    //Son necesarios los dos Container para expandir el tamaño del FAB
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: IdtColors.grayBtn,
            offset: Offset(0, 0),
            blurRadius: 18.0,
          )
        ]
      ),
      child: FloatingActionButton(
        elevation: 16,
        child: Container(
          width: 72,
          height: 72,
          decoration: homeSelected,
          child: Icon(
            IdtIcons.home,
            color: homeSelect ? IdtColors.white : IdtColors.grayBtn,
            size: 39,
          ),
        ),
        hoverColor: IdtColors.blackShadow,
        backgroundColor: IdtColors.white,
        onPressed: () {},
      ),
    );
  }
}
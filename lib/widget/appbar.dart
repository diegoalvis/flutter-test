import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IdtAppBar extends StatelessWidget implements PreferredSizeWidget {

  IdtAppBar(this.openMenu);

  final VoidCallback openMenu;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: SvgPicture.asset(
        IdtAssets.logo_bogota_black,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        height: 50.0,
        width: 100.0,
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          IdtAssets.back,
          color: IdtColors.black.withOpacity(0.9),
        ),
        iconSize: 22,
        padding: EdgeInsets.only(left: 10, bottom: 4),
        alignment: Alignment.bottomCenter,
        onPressed: (){},
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 12, bottom: 10),
          child: IconButton(
            autofocus: false,
            color: IdtColors.transparent,
            alignment: Alignment.bottomLeft,
            icon: Icon(
              IdtIcons.menu,
              color: IdtColors.black,
              size: 10.0,
            ),
            onPressed: openMenu,
          ),
        ),
      ],
      elevation: 15.0,
      shadowColor: IdtColors.blackShadow,
      toolbarHeight: 70.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      backgroundColor: IdtColors.white
    );
  }
}

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/pages/home_old/home_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bogota_app/bogota_icon.dart';


class AppBar_Component extends StatelessWidget implements PreferredSizeWidget {
  AppBar_Component({Key key, this.state_profile}) : super(key: key);
  final bool state_profile;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        titleSpacing: 50,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                //   color: Colors.red,
                height: 50,
                //width: 150,
                child: svg,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 30),
            child: IconButton(
              autofocus: false,
              //   padding: EdgeInsets.only(right: 40),
              //   mouseCursor: ,
              color: IdtColors.transparent,
              alignment: Alignment.centerRight,
              icon: Icon(
                Bogota_icon.menu,
                color: IdtColors.black,
                size: 10.0,
              ),
              onPressed: () {
                print("appbar");
                Navigator.pushNamed(
                  context,
                  Home_User.routeName,
                  arguments: Home_User(
                    state: state_profile,
                  ),
                );
                //    Navigator.pushNamed(context, Chat.routeName);
// do something
              },
            ),
          ),
        ],
        elevation: 28.0,
        toolbarHeight: 70.2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white);
  }

  Widget svg = SvgPicture.asset(
    IdtAssets.logo_bogota_black,
    fit: BoxFit.cover,
    alignment: Alignment.center,
    height: 50.0,
    width: 100.0,
    allowDrawingOutsideViewBox: true,
  );
}

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/app_theme.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:flutter/material.dart';

extension IdtDialog on BuildContext {
  void showDialogObservation(
      {required String titleDialog,
      required String bodyTextDialog,
      String textButton: 'aceptar / cerrar'}) {
    final textTheme = Theme.of(this).textTheme;
    final VoidCallback? onPressed;
    final _route = locator<IdtRoute>();

    showDialog(
        context: this,
        barrierColor: IdtColors.black.withOpacity(0.6),
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: IdtColors.white.withOpacity(0.9),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    titleDialog,
                    textAlign: TextAlign.center,
                    style: textTheme.textMenu
                        .copyWith(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 0),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(bodyTextDialog,
                      textAlign: TextAlign.center,
                      style: textTheme.textMenu.copyWith(fontSize: 16, letterSpacing: 0)),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        textColor: IdtColors.white,
                        color: IdtColors.orangeDark,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                        child: Text(
                          textButton.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        onPressed: _route.pop,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );

          /*return AlertDialog(
          title: Text(message),
          content: Text('a'),
          actions: [],
        );*/
        });
  }
}

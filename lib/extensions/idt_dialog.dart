import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/app_theme.dart';
import 'package:flutter/material.dart';

extension IdtDialog on BuildContext {

  void showDialogObservation(){

    final textTheme = Theme.of(this).textTheme;

    showDialog(
      context: this,
      barrierColor: IdtColors.black.withOpacity(0.7),
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Container(
            height: MediaQuery.of(this).size.height *0.4,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Mensaje de prueba',
                    style: textTheme.titleBlack,
                  ),
                  Text(
                    'Cuerpo del mensaje',
                    style: textTheme.subTitleBlack,
                  ),
                  RaisedButton(
                    child: Text(
                      'Cancelar',
                    ),
                    textColor: IdtColors.blue,
                    color: IdtColors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    onPressed: (){},
                  )
                ],
              ),
            ),
          ),
        );

        /*return AlertDialog(
          title: Text(message),
          content: Text('a'),
          actions: [],
        );*/
      }
    );

  }
}
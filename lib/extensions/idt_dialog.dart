import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/app_theme.dart';
import 'package:flutter/material.dart';

extension IdtDialog on BuildContext {

  void showDialogObservation(String message){

    final textTheme = Theme.of(this).textTheme;
    final VoidCallback ? onPressed;

    showDialog(
      context: this,
      barrierColor: IdtColors.black.withOpacity(0.7),
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Container(
            height: MediaQuery.of(this).size.height *0.2,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
/*                  Text(
                    'Mensaje de prueba',
                    style: textTheme.titleBlack,
                  ),*/
                  Image(image: AssetImage(IdtAssets.logo_bogota_black),
                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 100.0,
                  ),
                  Text(
                    message,
                    style: textTheme.subTitleBlack,
                  ),
                  RaisedButton(
                    child: Text(
                      'Cancelar',
                    ),
                    textColor: IdtColors.blue,
                    color: IdtColors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    onPressed: (){

                      Navigator.of(context).pop();
                    },
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
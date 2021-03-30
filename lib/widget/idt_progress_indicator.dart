import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/app_theme.dart';

class IdtProgressIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          height: MediaQuery.of(context).size.width/1.7,
          decoration: BoxDecoration(
            color: IdtColors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IdtAssets.logo_bogota,
                  height: 125.0,
                  width: 125.0,
                ),
                Text(
                  'Cargando...',
                  style: Theme.of(context).textTheme.titleBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/app_theme.dart';

class IdtProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: IdtColors.white.withOpacity(0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            IdtAssets.loading,
            height: 125.0,
            width: 125.0,
          ),
          Text(
            'Cargando...',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleBlack,
          ),
        ],
      ),
    );
  }
}

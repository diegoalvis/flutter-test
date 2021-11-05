import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/register_user/register_user_view_model.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/app_theme.dart';

class Alert extends StatelessWidget {
  late final VoidCallback goRegister;

  late final IdtRoute _route;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 400,
      height: 400,
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
                  IdtAssets.loading,
                  height: 125.0,
                  width: 125.0,
                ),
                Text(
                  'Alert',
                  style: Theme.of(context).textTheme.titleBlack,
                ),
                BtnGradient(
                    'Crear cuenta',
                    colorGradient: IdtGradients.orange,
                    textStyle: textTheme.textButtomWhite.copyWith(
                        fontSize: 16, letterSpacing: 0.0, fontWeight: FontWeight.w700),

                    onPressed: () => _route.goHome()//COmentado para probar la llega de diccionario al home
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

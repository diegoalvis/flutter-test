import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app_theme.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
     // theme: kThemeData,
      home: HomePage(),
      theme: AppTheme.build(),
    );
  }
}


class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Column(
          children: [
            Image(
              image: AssetImage(IdtAssets.bogota_dc_travel),
              width: size.width,
              height: size.height ,
              fit: BoxFit.fill,
            ),
          ],
        ),

        Positioned(
            top: 400,
            // bottom: 100,
            left: 0,
            right: 0,
            child: SizedBox(
              child: Image(image: AssetImage(IdtAssets.curve_up),
                  height: size.height * 0.8
              ),

/*                SvgPicture.asset(IdtAssets.curve_up,
                    color: IdtColors.white, fit: BoxFit.fill),*/
            )),
        Positioned(
          top: 50.0,
          bottom: 550.0,
          left: 0.0,
          right: 0.0,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(0, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                  height: 105,
                  width: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IdtAssets.logo_bogota),
                      fit: BoxFit.scaleDown,
                    ),
                  )),
            ),
          ),
        ),
        Positioned(
          bottom: 600,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'App Oficial de Bogotá',
                      style: textTheme.textWhiteShadow.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
        Positioned(
          bottom: 540,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'BIENVENIDO',
                      style: textTheme.textWhiteShadow.copyWith(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
        Positioned(
          bottom: 515,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Lorem adipiscing elit, sed diam aSDSA dasd ',
                      style: textTheme.textWhiteShadow.copyWith(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 210,
            left: 50,
            child: SizedBox(
              child: Container(
                width: 300,
                height: 300,
                color: Colors.transparent,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 55,
                      width: 300,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.perm_contact_calendar_rounded, color: Colors.white,),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(50.0),
                              ),
                            ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                            hintText: 'Usuario',
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.white),
                            fillColor: Colors.transparent,
                            isDense: true,                      // Added this
                            contentPadding: EdgeInsets.all(1),

                          ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Container(
                        height: 40,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key_outlined, color: Colors.white,),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(50.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                            ),
                            ),

                            hintText: 'Contraseña',
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.white),
                            fillColor: Colors.transparent,
                            isDense: true,                      // Added this
                            contentPadding: EdgeInsets.all(1),
                          ),
                          maxLines: 1,
                          minLines: 1,
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                        ),
                      ),
                    ),
                  ],
                ),

              ),
              ),

/*                SvgPicture.asset(IdtAssets.curve_up,
                    color: IdtColors.white, fit: BoxFit.fill),*/
            )),
        Positioned(
            bottom: 320,
            left: 30,
            child: Container(
          margin: EdgeInsets.all(25),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: IdtColors.orangeDark, width: 1),
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Container(
                constraints: BoxConstraints(
                    maxWidth: 290.0,
                    minWidth: 180,
                    minHeight: 40.0,
                    maxHeight: 40),
                decoration: StylesMethodsApp().decorarStyle(IdtGradients.orange, 30,
                    Alignment.bottomCenter, Alignment.topCenter),
                alignment: Alignment.center,
                child: Text(
                  'Iniciar Sesión',
                  textAlign: TextAlign.center,
                  style: textTheme.textButtomWhite.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold)
                )),
           onPressed: null,
          ),
        )),
        Positioned(
          bottom: 300,
          left: 100,
          child:         Container(
            color: Colors.transparent,
            width: 200,
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                     Icons.radio_button_off_rounded,
                color: Colors.white,size: 15,),
                SizedBox(width: 6,),
                Text('Recordarme',style: textTheme.textWhiteShadow.copyWith(
                fontSize: 13, fontWeight: FontWeight.normal)),
              ],
            )
          ),
        ),

        Positioned(
          bottom: 280,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '¿Olvidó su contraseña?',
                      style: textTheme.textWhiteShadow.copyWith(
                          fontSize: 13, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
/*
        Positioned(
          bottom: 150,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '3.3/5',
                      style: textTheme.textWhiteShadow.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
*/

        Positioned(
            bottom: 140,
            left: 30,
            child: Container(
              margin: EdgeInsets.all(25),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: IdtColors.blueDark, width: 1),
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Container(
                    constraints: BoxConstraints(
                        maxWidth: 300.0,
                        minWidth: 180,
                        minHeight: 40.0,
                        maxHeight: 40),
                    decoration: StylesMethodsApp().decorarStyle(IdtGradients.blue, 30,
                        Alignment.bottomCenter, Alignment.topCenter),
                    alignment: Alignment.center,
                    child: Text(
                      'Crear Cuenta',
                      textAlign: TextAlign.center,
                      style: textTheme.textButtomWhite.copyWith(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                    )),
                onPressed: null,
              ),
            )),
        Positioned(
          bottom: 140,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'O registrate con',
                      style: textTheme.textDetail.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 60,
            left: 50,
            child: Container(
              color: Colors.white,
              height: 60,
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(color: Colors.white,
                  child: Image(image:AssetImage(IdtAssets.facebook)),
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 8,),
                Container(color: Colors.white,
                  width: 40,
                  height: 40,
                  child: Image(
                      image:AssetImage(IdtAssets.google),
                  ),

                ),
                SizedBox(width: 8,),
                  Container(color: Colors.white,
                    width: 50,
                    height: 50,
                    child: Image(
                      image:AssetImage(IdtAssets.apple),
                    ),

                  )
              ],),
            )),
        Positioned(
          bottom: 10,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Oficina de Turismo de Bogotá',
                      style: textTheme.textDetail.copyWith(
                          fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }


}


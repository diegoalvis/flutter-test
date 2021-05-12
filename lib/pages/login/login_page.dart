import 'dart:ui';
import 'dart:async';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/%20recover_pass/recover_pass_page.dart';
import 'package:bogota_app/pages/login/login_view_model.dart';
import 'package:bogota_app/pages/register_user/register_user_page.dart';
import 'package:bogota_app/widget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/widget/style_method.dart';
import '../../app_theme.dart';
import 'login_effect.dart';

import 'package:bogota_app/extensions/idt_dialog.dart';

class LoginPage extends StatelessWidget {
  LoginPage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return LoginWidget();
      },
    );
  }
}

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  StreamSubscription<LoginEffect>? _effectSubscription;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<LoginViewModel>().onInit();
    });

    emailController.addListener(_printLatestValue);
    passwordController.addListener(_printLatestValue);

    super.initState();
  }

  _showAlert() {
    final viewModel = context.read<LoginViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is LoginValueControllerScrollEffect) {
        print('scroll controler');
        context.showDialogObservation(titleDialog: 'oh oh!\n Algo ha salido mal...',bodyTextDialog: viewModel.status.message!,textButton: 'aceptar / cerrar');
      } else if (event is ShowLoginDialogEffect) {
        print('entra a event');
        print(viewModel.status.message!);
        if (viewModel.status.message != null) {
          context.showDialogObservation(titleDialog: 'oh oh!\n Algo ha salido mal...',bodyTextDialog: viewModel.status.message!, textButton: 'aceptar / cerrar');
          viewModel.status.message = null;
        }
      }
    });
  }

  _printLatestValue() {
    print("Second text field: ${emailController.text}");
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    InputDecoration KTextFieldDecoration(IconData icon) {
      return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
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
        hintText: 'Correo Electrónico',
        filled: true,
        hintStyle: new TextStyle(color: Colors.white),
        fillColor: Colors.transparent,
        isDense: true,
        // Added this
        contentPadding: EdgeInsets.all(1),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage(IdtAssets.bogota_dc_travel),
                  width: size.width,
                  height: size.height,
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
                  child: Image(image: AssetImage(IdtAssets.curve_up), height: size.height * 0.8),

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
                      colors: [Color.fromARGB(0, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
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
                          style: textTheme.textWhiteShadow
                              .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
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
                          style: textTheme.textWhiteShadow
                              .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
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
                          style: textTheme.textWhiteShadow
                              .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
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
                          TextFieldCustom(
                            keyboardType: TextInputType.emailAddress,
                            style: textTheme.textButtomWhite,
                            controller: emailController,
                            cursorColor: Colors.white,
                            decoration: KTextFieldDecoration(Icons.email_outlined)
                                .copyWith(hintText: 'Correo electrónico'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFieldCustom(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.emailAddress,
                            style: textTheme.textButtomWhite,
                            controller: passwordController,
                            obscureText: true,
                            decoration: KTextFieldDecoration(Icons.vpn_key)
                                .copyWith(hintText: 'Contraseña'),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                              maxWidth: 290.0, minWidth: 180, minHeight: 40.0, maxHeight: 40),
                          decoration: StylesMethodsApp().decorarStyle(
                              IdtGradients.orange, 30, Alignment.bottomCenter, Alignment.topCenter),
                          alignment: Alignment.center,
                          child: Text('Iniciar Sesión',
                              textAlign: TextAlign.center,
                              style: textTheme.textButtomWhite
                                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold))),
                      onPressed: () {
                        viewModel.loginResponse(emailController.text, passwordController.text);
                        _showAlert();
                      }),
                )),
            Positioned(
              bottom: 300,
              left: 100,
              child: Container(
                  color: Colors.transparent,
                  width: 200,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.radio_button_off_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Recordarme',
                          style: textTheme.textWhiteShadow
                              .copyWith(fontSize: 13, fontWeight: FontWeight.normal)),
                    ],
                  )),
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
                        GestureDetector(
                          child: Text(
                            '¿Olvidó su contraseña?',
                            style: textTheme.textWhiteShadow
                                .copyWith(fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RecoverPassPage()),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                              maxWidth: 300.0, minWidth: 180, minHeight: 40.0, maxHeight: 40),
                          decoration: StylesMethodsApp().decorarStyle(
                              IdtGradients.blue, 30, Alignment.bottomCenter, Alignment.topCenter),
                          alignment: Alignment.center,
                          child: Text(
                            'Crear Cuenta',
                            textAlign: TextAlign.center,
                            style: textTheme.textButtomWhite.copyWith(
                                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterUserPage()),
                        );
                      }),
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
                      Container(
                        color: Colors.white,
                        child: Image(image: AssetImage(IdtAssets.facebook)),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        color: Colors.white,
                        width: 40,
                        height: 40,
                        child: Image(
                          image: AssetImage(IdtAssets.google),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        color: Colors.white,
                        width: 50,
                        height: 50,
                        child: Image(
                          image: AssetImage(IdtAssets.apple),
                        ),
                      )
                    ],
                  ),
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
        ),
      ),
    );
  }
}

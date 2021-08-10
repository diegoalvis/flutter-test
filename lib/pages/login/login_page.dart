import 'dart:convert';
import 'dart:ui';

import 'dart:async';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/%20recover_pass/recover_pass_page.dart';
import 'package:bogota_app/pages/login/login_view_model.dart';
import 'package:bogota_app/pages/register_user/register_user_page.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/login_buttons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleapis/datastore/v1.dart';
import 'package:provider/provider.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/widget/style_method.dart';
import '../../app_theme.dart';
import 'login_effect.dart';

import 'package:bogota_app/extensions/idt_dialog.dart';

class LoginPage extends StatelessWidget {
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
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  StreamSubscription<LoginEffect>? _effectSubscription;
  bool rememberMe = false;

  @override
  initState() {
    BoxDataSesion();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<LoginViewModel>().onInit();
    });
    _loadDataRemember();
    emailController.addListener(_printLatestValue);
    passwordController.addListener(_printLatestValue);
    //_checkIfIsLogged();
    super.initState();
  }

  _loadDataRemember() async {
    RememberMe? remember = await BoxDataSesion.getFromRememberBox(0);
    if (remember!.state) {
      emailController.text = remember.email;
      passwordController.text = remember.password;
      final viewModel = context.read<LoginViewModel>();
      viewModel.status.rememberMe = remember.state;
      print("viewModel.status.rememberMe ${viewModel.status.rememberMe}");
    }
  }

  _showAlert() {
    final viewModel = context.read<LoginViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is LoginValueControllerScrollEffect) {
        print('scroll controler');
        context.showDialogObservation(
            titleDialog: 'oh oh!\n Algo ha salido mal...',
            bodyTextDialog: viewModel.status.message!,
            textPrimaryButton: 'aceptar / cerrar');
      } else if (event is ShowLoginDialogEffect) {
        print('entra a event');
        print(viewModel.status.message!);
        if (viewModel.status.message != null) {
          context.showDialogObservation(
              titleDialog: 'oh oh!\n Algo ha salido mal...',
              bodyTextDialog: viewModel.status.message!,
              textPrimaryButton: 'aceptar / cerrar');
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
    final sizeScreen = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    InputDecoration KTextFieldDecoration(IconData icon) {
      return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        errorStyle: TextStyle(color: IdtColors.white),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70, width: 2.0),
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
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
        filled: true,
        labelStyle: new TextStyle(color: Colors.white),
        hintStyle: new TextStyle(color: Colors.red),
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
            Image(
              // Imagen De fondo Login
              image: AssetImage(IdtAssets.bogota_dc_travel),
              height: sizeScreen.height,
              fit: BoxFit.fill,
            ),
            Form(
              key: _formKey,
              child: Container(
                height: sizeScreen.height * 0.6,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(),
                      SizedBox(
                        height: 12,
                      ),
                      Image.asset(
                        IdtAssets.logo_bogota,
                        // height: 100,
                        height: scaleSmallDevice(context),
                      ),
                      Text(
                        'App Oficial de Bogotá',
                        style: textTheme.textWhiteShadow
                            .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'BIENVENIDO',
                        style: textTheme.textWhiteShadow
                            .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (value) => viewModel.validateEmail(value!, emailController.text),
                        style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                        controller: emailController,
                        decoration: KTextFieldDecoration(Icons.email_outlined).copyWith(
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Spacer(),
                      TextFormField(
                        validator: (value) => viewModel.validatePassword(value!),
                        keyboardType: TextInputType.emailAddress,
                        style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            KTextFieldDecoration(Icons.vpn_key).copyWith(labelText: 'Contraseña'),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Spacer(),
                      BtnGradient('Iniciar Sesión',
                          colorGradient: IdtGradients.orange,
                          textStyle: textTheme.textButtomWhite.copyWith(
                              fontSize: 16,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w700), onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.loginResponse(emailController.text, passwordController.text);
                        } else {
                          _showAlert();
                        }
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                      }),
                      SizedBox(
                        height: 12,
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => viewModel.rememberMe(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                viewModel.status.rememberMe!
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Recordarme',
                                style: textTheme.textWhiteShadow
                                    .copyWith(fontSize: 13, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              //CURVA
              top: sizeScreen.height * 0.6,
              child: SvgPicture.asset(IdtAssets.curve_up,
                  width: sizeScreen.width, color: IdtColors.white, fit: BoxFit.contain),
            ),
            Positioned(
              top: sizeScreen.height * 0.6,
              width: sizeScreen.width,
              child: Container(
                height: sizeScreen.height * 0.4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '¿Olvidó su contraseña?',
                                style: textTheme.textWhiteShadow
                                    .copyWith(fontSize: 13, fontWeight: FontWeight.normal),
                              ),
                            ),
                            onTap: () {
                              print("navegacion a recover Pass");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RecoverPassPage()),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      BtnGradient('Crear Cuenta',
                          colorGradient: IdtGradients.blue,
                          textStyle: textTheme.textButtomWhite.copyWith(
                              fontSize: 16,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w700), onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterUserPage()),
                        );
                      }),
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        'O inicia sesión con',
                        style: textTheme.textDetail.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                      ),
                      Spacer(),
                      LoginButtons(
                          logout: viewModel.logOut, login: viewModel.login, alert: _showAlert()),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 30,
                width: sizeScreen.width,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Oficina de Turismo de Bogotá',
                    style: textTheme.textDetail
                        .copyWith(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            loading
          ],
        ),
      ),
    );
  }
}

double scaleSmallDevice(BuildContext context) {
  final size = MediaQuery.of(context).size;
  // For tiny devices.
  if (size.height < 600) {
    return 100;
  }
  // For normal devices.
  return 150;
}


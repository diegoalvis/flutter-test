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
import 'package:bogota_app/widget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    InputDecoration KTextFieldDecoration(IconData icon) {
      return InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
            Image( // Imagen De fondo Login
              image: AssetImage(IdtAssets.bogota_dc_travel),
              height: size.height,
              fit: BoxFit.fill,
            ),
            Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height*0.7,
                color: IdtColors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 50,),
                    Image.asset(IdtAssets.logo_bogota),
                    Text(
                      'App Oficial de Bogotá',
                      style: textTheme.textWhiteShadow
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Text(
                      'BIENVENIDO',
                      style: textTheme.textWhiteShadow
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa tu Email';
                        }
                        return null;
                      },
                      style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                      controller: emailController,
                      decoration: KTextFieldDecoration(Icons.email_outlined).copyWith(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                      controller: passwordController,
                      obscureText: true,
                      decoration:
                          KTextFieldDecoration(Icons.vpn_key).copyWith(labelText: 'Contraseña'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BtnGradient(
                      'Iniciar Sesión',
                      colorGradient: IdtGradients.orange,
                      textStyle: textTheme.textButtomWhite
                          .copyWith(fontSize: 16, letterSpacing: 0.0, fontWeight: FontWeight.w700),
                      onPressed: () => {
                        //TODO LOGIN
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(
                            viewModel.status.rememberMe!
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                          onTap: () => viewModel.rememberMe(),
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
                    SizedBox(
                      height: 20,
                    ),
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
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              child: SvgPicture.asset(IdtAssets.curve_up,
                  width: size.width, color: IdtColors.white, fit: BoxFit.contain),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.72,
              child: Column(
                children: [
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
                  Text(
                    'O inicia sesión con',
                    style: textTheme.textDetail
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                  LoginButtons(
                      logout: viewModel.logOut, login: viewModel.login, alert: _showAlert()),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 0,
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
            // Positioned(
            //     top: size.height * 0.55,
            //     // bottom: 100,
            //     left: 0,
            //     right: 0,
            //     child: SizedBox(
            //       child:
            //           SvgPicture.asset(IdtAssets.curve_up,
            //               width: size.width, color: IdtColors.white, fit: BoxFit.contain),
            //     )),

            // Positioned(
            //     bottom: size.height * 0.4,
            //     child: Container(
            //       margin: EdgeInsets.all(25),
            //       child: ,
            //     )),

            loading
          ],
        ),
      ),
    );
  }
}

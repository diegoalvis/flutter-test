import 'dart:async';
import 'dart:convert';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/model/request/register_request.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/pages/register_user/register_user_effect.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/login_buttons.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:bogota_app/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import 'countries.dart';
import 'register_user_effect.dart';
import 'register_user_view_model.dart';
import 'package:bogota_app/extensions/idt_dialog.dart';

import 'package:http/http.dart' as http;

class RegisterUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterUserViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return RegisterUserWidget();
      },
    );
  }
}

class RegisterUserWidget extends StatefulWidget {
  @override
  _RegisterUserWidgetState createState() => _RegisterUserWidgetState();
}

class _RegisterUserWidgetState extends State<RegisterUserWidget> {
  final URL_COUNTRIES_CITYS =
      'https://raw.githubusercontent.com/russ666/all-countries-and-cities-json/6ee538beca8914133259b401ba47a550313e8984/countries.json';
  final _controllerName = TextEditingController();
  final _controllerLastNames = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPass = TextEditingController();
  final _controllerConfirmPass = TextEditingController();
  final scrollController = ScrollController();
  List<String> countries = [];
  List<String> citiesFilterByCountry = [];
  Map<String, List<String>> countriesComplete = {};
  String dropdownValueReasonTrip = 'Motivo de Viaje';
  String dropdownValueCountry = 'Colombia';
  var dropdownValueCity;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  StreamSubscription<RegisterEffect>? _effectSubscription;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<RegisterUserViewModel>().onInit();
    });

    stateValue = "";
    cityValue = "";
    address = "";

    // _controllerEmail.text = '';
    // _controllerName.text = '';
    // _controllerLastNames.text = '';
    // _controllerEmail.text = '';
    // _controllerPass.text = '';
    // _controllerConfirmPass.text = '';

    final viewModel = context.read<RegisterUserViewModel>();

    chargeCountriesAndCities();
    _validatePassword(_controllerPass);
    _validatePassword(_controllerConfirmPass);
    super.initState();
  }

  _validatePassword(TextEditingController controller) {
    controller.addListener(() {
      if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(controller.text)) {
        showSnack('Solo se permiten caracteres \n alfanuméricos', onPressed: null, duration: null);
        final text = controller.text;
        controller.text = text.replaceAll(new RegExp(r'(?![a-zA-Z0-9]).'), '');
        controller.selection =
            TextSelection.fromPosition(TextPosition(offset: controller.text.length));
      }
    });
  }

  void chargeCountriesAndCities() {
    Map<String, List<String>> list = DataUtil.countries;
    countriesComplete = list;
    countries = list.entries.map((e) => e.key).toList();
    _chargeCitiesByCountry();
  }

  _showAlert() {
    final viewModel = context.read<RegisterUserViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is RegisterValueControllerScrollEffect) {
        print('scroll controler');
        context.showDialogObservation(
            titleDialog: 'oh oh!\n Algo ha salido mal...',
            bodyTextDialog: viewModel.status.message!,
            textPrimaryButton: 'aceptar / cerrar');
      } else if (event is ShowRegisterDialogEffect) {
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

  showMessagePasswordLength(String text) {
    context.showDialogObservation(
        titleDialog: 'oh oh!\n Algo ha salido mal...',
        bodyTextDialog: text,
        textPrimaryButton: 'aceptar / cerrar');
  }

  showSnack(String title, {Function? onPressed, int? duration}) {
    final snackbar = SnackBar(
        duration: Duration(seconds: duration ?? 2),
        action: SnackBarAction(
          onPressed: onPressed == null ? () {} : onPressed(),
          label: 'Cerrar',
        ),
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ));
    scaffoldMessengerKey.currentState?.showSnackBar(
      snackbar,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterUserViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: IdtColors.white,
        body: _buildRegisterUser(viewModel),
      ),
    );
  }

  Widget _buildRegisterUser(RegisterUserViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final _route = locator<IdtRoute>();
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();
    // RegisterRequest params = RegisterRequest(
    //     // 'name','name','name@gmail.com', 'col', 'apellido', 'asd', '1234'
    //     _controllerName.text,_controllerName.text, _controllerEmail.text, 'Colombia', _controllerLastNames.text, 'turismo', _controllerPass.text
    // );

    _onSuccessRegister() {
      context.showDialogObservation(
          titleDialog: 'Éxito',
          bodyTextDialog: 'Cuenta creada exitosamente!',
          textPrimaryButton: 'aceptar / cerrar',
          actionPrimaryButtom: _route.goHome);
    }

    _register() {
      print('register user page');
      // print(params.reason_trip);
      // print(params.toJson());
      // viewModel.status.data = params;
      context.read<RegisterUserViewModel>().registerResponse(
          _controllerName.text,
          _controllerLastNames.text,
          dropdownValueCountry,
          dropdownValueReasonTrip,
          _controllerEmail.text,
          dropdownValueCity,
          _controllerPass.text,
          _onSuccessRegister);
      _showAlert();
    }

    _validations() {
      String validationResult = '';
      validationResult = viewModel.validateEmail(_controllerEmail.text);
      if (validationResult != 'null') {
        viewModel.status.message = validationResult;
        return _showAlert();
      }

      if (viewModel.validatePassword(_controllerPass.text, _controllerConfirmPass.text)) {
        if (_controllerPass.text.length >= 8) {
          return _register();
        } else {
          showMessagePasswordLength(
              "La contraseña debe incluir al menos 8 caracteres alfanuméricos");
        }
      } else {
        viewModel.status.message = "Las contraseñas no coinciden";
        return _showAlert();
      }
    }

    final KTextFieldDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      isDense: true,
      hintStyle: textTheme.textButtomWhite
          .copyWith(color: IdtColors.grayBtn, fontSize: 15, fontWeight: FontWeight.w500),
      hintText: '.copyWith',
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          width: 1,
          color: IdtColors.gray,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          width: 1.4,
          color: IdtColors.black,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
    );

    Widget _header() {
      return Stack(
        children: [
          Image(
            //imagen de fondo
            image: AssetImage(IdtAssets.bogota_dc_travel),
            width: size.width,
            height: size.height * 0.58,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            top: size.height / 2 * 0.79,
            // bottom: 100,
            left: 0,
            right: 0,
            child: SizedBox(
              //  child: Image(image: AssetImage(IdtAssets.curve_up), height: size.height * 0.9),
              child: SvgPicture.asset(IdtAssets.curve_up, color: IdtColors.white, fit: BoxFit.fill),
            ),
          ),
          Positioned(
            // Logo de bogota
            bottom: size.height / 2 * 0.32,
            width: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  IdtAssets.logo_bogota,
                  height: 140,
                  fit: BoxFit.scaleDown,
                ),
                Positioned(
                  bottom: 0,
                  child: Text(
                    'App Oficial de Bogotá',
                    style: textTheme.textWhiteShadow
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: size.height / 2 * 1.02,
              width: size.width,
              child: Column(
                children: [
                  Text(
                    'BIENVENIDO',
                    style: textTheme.textMenu.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: IdtColors.gray,
                        letterSpacing: 0.0),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ))
        ],
      );
    }

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
                // reverse: true,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: _header(),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: IdtColors.transparent,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Container(
                              height: size.height * 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(height: 10),
                                  TextFieldCustom(
                                      keyboardType: TextInputType.name,
                                      style: textTheme.textDetail,
                                      controller: _controllerName,
                                      decoration:
                                          KTextFieldDecoration.copyWith(hintText: 'Nombre')),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFieldCustom(
                                    keyboardType: TextInputType.name,
                                    style: textTheme.textDetail,
                                    controller: _controllerLastNames,
                                    decoration:
                                        KTextFieldDecoration.copyWith(hintText: 'Apellidos'),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 38,
                                    width: double.infinity,
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: IdtColors.gray),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text('Motivo del Viaje'),
                                      isDense: true,
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: IdtColors.grayBtn,
                                      ),
                                      iconSize: 38,
                                      style: textTheme.textButtomWhite.copyWith(
                                          color: IdtColors.grayBtn,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                      items: <String>[
                                        'Vacaciones / recreación / ocio',
                                        'Visita a familiares y amigos',
                                        'Negocios y motivos profesionales',
                                        'Trabajo remunerado'
                                            'Educación y formación',
                                        'Compras',
                                        'Religión/peregrinaciones',
                                        'Salud y atención médica',
                                        'otros motivos',
                                        'Motivo de Viaje',
                                      ].map<DropdownMenuItem<String>>((String option) {
                                        return DropdownMenuItem<String>(
                                          child: Text(
                                            '$option',
                                            // style: textTheme.textDetail,
                                          ),
                                          value: option,
                                        );
                                      }).toList(),
                                      value: dropdownValueReasonTrip,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValueReasonTrip = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 38,
                                    width: double.infinity,
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: IdtColors.gray),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text('País'),
                                      isDense: true,
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: IdtColors.grayBtn,
                                      ),
                                      iconSize: 38,
                                      style: textTheme.textButtomWhite.copyWith(
                                          color: IdtColors.grayBtn,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                      items:
                                          countries.map<DropdownMenuItem<String>>((String option) {
                                        return DropdownMenuItem<String>(
                                          child: Text(
                                            '$option',
                                            // style: textTheme.textDetail,
                                          ),
                                          value: option,
                                        );
                                      }).toList(),
                                      value: dropdownValueCountry,
                                      onChanged: (String? newCountryValue) {
                                        setState(() {
                                          dropdownValueCountry = newCountryValue!;
                                          _chargeCitiesByCountry();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 38,
                                    width: double.infinity,
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: IdtColors.gray),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text('Ciudad'),
                                      isDense: true,
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: IdtColors.grayBtn,
                                      ),
                                      iconSize: 38,
                                      style: textTheme.textButtomWhite.copyWith(
                                          color: IdtColors.grayBtn,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                      items: citiesFilterByCountry
                                          .map<DropdownMenuItem<String>>((String option) {
                                        return DropdownMenuItem<String>(
                                          child: Text(
                                            '$option',
                                            // style: textTheme.textDetail,
                                          ),
                                          value: option,
                                        );
                                      }).toList(),
                                      value: dropdownValueCity,
                                      onChanged: (String? newCountryValue) {
                                        setState(() {
                                          dropdownValueCity = newCountryValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFieldCustom(
                                    keyboardType: TextInputType.emailAddress,
                                    style: textTheme.textDetail,
                                    controller: _controllerEmail,
                                    decoration: KTextFieldDecoration.copyWith(
                                        hintText: 'Correo electrónico'),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFieldCustom(
                                    keyboardType: TextInputType.visiblePassword,
                                    style: textTheme.textDetail,
                                    controller: _controllerPass,
                                    obscureText: true,
                                    decoration:
                                        KTextFieldDecoration.copyWith(hintText: 'Contraseña'),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFieldCustom(
                                    style: textTheme.textDetail,
                                    controller: _controllerConfirmPass,
                                    obscureText: true,
                                    decoration: KTextFieldDecoration.copyWith(
                                        hintText: 'Confirmar contraseña'),
                                  ),
                                  Spacer(),
                                  BtnGradient(
                                    'Crear cuenta',
                                    colorGradient: IdtGradients.orange,
                                    textStyle: textTheme.textButtomWhite.copyWith(
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w700),
                                    onPressed: () => _validations(),
                                  ),
                                  LoginButtons(
                                      logout: viewModel.logOut,
                                      login: viewModel.login,
                                      alert: _showAlert()),
                                  Spacer(),
                                  Text(
                                    'Oficina de turismo de Bogotá',
                                    style: textTheme.textDetail.copyWith(
                                      fontSize: 8.5,
                                      color: IdtColors.gray,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
            loading
          ],
        ),
      ),
    );
  }

  // Carga listado de paises según sea el país seleccionado
  void _chargeCitiesByCountry() {
    citiesFilterByCountry.clear();
    countriesComplete.forEach((key, value) {
      if (key == dropdownValueCountry) {
        citiesFilterByCountry = value;
        citiesFilterByCountry = citiesFilterByCountry.toSet().toList();
        print(citiesFilterByCountry);
        dropdownValueCity = null;
      }
    });
  }
}

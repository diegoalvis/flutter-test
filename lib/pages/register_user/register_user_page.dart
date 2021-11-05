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
import 'package:flutter/material.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:flutter/services.dart';
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
      create: (_) =>
          RegisterUserViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
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
  var dropdownValueReasonTrip;
  String dropdownValueCountry = 'Colombia';
  var dropdownValueCity;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  StreamSubscription<RegisterEffect>? _effectSubscription;
  final _formKey = GlobalKey<FormState>();
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

    chargeCountriesAndCities();
    _validatePassword(_controllerPass);
    _validatePassword(_controllerConfirmPass);
    super.initState();
  }

  _validatePassword(TextEditingController controller) {
    // controller.addListener(() { //validacion de no caracteres especiales
    //   if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(controller.text)) {
    //     // showSnack('Solo se permiten caracteres \n alfanuméricos',
    //     //     onPressed: null, duration: null);
    //     final text = controller.text;
    //     controller.text = text.replaceAll(new RegExp(r'(?![a-zA-Z0-9]).'), '');
    //     controller.selection = TextSelection.fromPosition(
    //         TextPosition(offset: controller.text.length));
    //   }
    // });
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
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: _buildRegisterUser(viewModel)),
      ),
    );
  }

  Widget _buildRegisterUser(RegisterUserViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;

    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();
    // RegisterRequest params = RegisterRequest(
    //     // 'name','name','name@gmail.com', 'col', 'apellido', 'asd', '1234'
    //     _controllerName.text,_controllerName.text, _controllerEmail.text, 'Colombia', _controllerLastNames.text, 'turismo', _controllerPass.text
    // );

    _validations() {
      //revisar estas validaciones
      String validationResult = '';
      // validationResult = viewModel.validateEmail(_controllerEmail.text); //esta validacion ya se hace con la propiedad validator
      if (validationResult != 'null') {
        viewModel.status.message = validationResult;
        return _showAlert();
      }

      // if (viewModel.validatePassword(_controllerPass.text, _controllerConfirmPass.text)) {
      //   if (_controllerPass.text.length >= 8) {
      //     return _register();
      //   } else {
      //     showMessagePasswordLength(
      //         "La contraseña debe incluir al menos 8 caracteres alfanuméricos");
      //   }
      // } else {
      //   viewModel.status.message = "Las contraseñas no coinciden";
      //   return _showAlert();
      // }
    }

    InputDecoration KTextFieldDecoration() {
      return InputDecoration(
        contentPadding:
            EdgeInsets.only(bottom: 6, top: 14, left: 20, right: 20),
        errorStyle: TextStyle(color: IdtColors.red),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1.3),
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26, width: 1),
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26, width: 1),
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1.3),
          borderRadius: const BorderRadius.all(
            const Radius.circular(50.0),
          ),
        ),

        labelStyle: new TextStyle(color: Colors.black54),
        //textTheme.textButtomWhite
        //           .copyWith(color: IdtColors.grayBtn, fontSize: 15, fontWeight: FontWeight.w500),
        // fillColor: Colors.transparent,
        isDense: true,
        // Added this
      );
    }

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image(
                // Imagen De fondo Login
                image: AssetImage(IdtAssets.bogota_dc_travel),
                height: sizeScreen.height,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  //completa la parte inferior blanca de la pagina
                  height: sizeScreen.height * 0.4,
                  width: sizeScreen.width,
                  color: Colors.white,
                ),
              ),
              Container(
                height: sizeScreen.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      IdtAssets.logo_bogota,
                      // height: 100,
                      height: scaleSmallDevice(context),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'App Oficial de Bogotá',
                        style: textTheme.textWhiteShadow.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Positioned(
                //CURVA
                top: sizeScreen.height * 0.3,
                child: SvgPicture.asset(IdtAssets.curve_up,
                    width: sizeScreen.width,
                    color: IdtColors.white,
                    fit: BoxFit.contain),
              ),
              Column(
                children: [
                  Container(
                    height: sizeScreen.height * 0.42,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'BIENVENIDO',
                    style: textTheme.textMenu.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: IdtColors.gray,
                        letterSpacing: 0.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z ]"))
                                //validado solo letras y espacio
                              ],
                              validator: (value) =>
                                  viewModel.validateName(value),
                              style: textTheme.textButtomWhite.copyWith(
                                  fontSize: 16, color: Colors.black87),
                              controller: _controllerName,
                              decoration: KTextFieldDecoration().copyWith(
                                labelText: 'Nombres',
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z ]"))
                                //validado solo letras y espacio
                              ],
                              validator: (value) =>
                                  viewModel.validateLastName(value),
                              keyboardType: TextInputType.name,
                              style: textTheme.textDetail,
                              controller: _controllerLastNames,
                              decoration: KTextFieldDecoration()
                                  .copyWith(labelText: 'Apellidos'),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            // COntainer(height: 38,
                            //   width: double.infinity,
                            //   padding: EdgeInsets.only(left: 20),
                            //   decoration: BoxDecoration(
                            //       border: Border.all(color: Colors.black26, width: 1.3),
                            //       borderRadius: BorderRadius.all(Radius.circular(20))),)
                            DropdownButtonFormField<String>(
                              decoration: KTextFieldDecoration().copyWith(
                                  contentPadding: EdgeInsets.only(
                                      bottom: 0, top: 0, left: 20, right: 5)),
                              validator: (value) => value == null
                                  ? '* Campo motivo de viaje es necesario'
                                  : null,
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
                                // 'Motivo de Viaje',
                              ].map<DropdownMenuItem<String>>((String option) {
                                return DropdownMenuItem<String>(
                                  child: Text('$option',
                                      style: TextStyle(color: Colors.black54)),
                                  value: option,
                                );
                              }).toList(),
                              // value: dropdownValueReasonTrip,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueReasonTrip = newValue!;
                                });
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            DropdownButtonFormField<String>(
                              decoration: KTextFieldDecoration().copyWith(
                                  contentPadding: EdgeInsets.only(
                                      bottom: 0, top: 0, left: 20, right: 5)),
                              // validator: (value) => value == null ? '* Motivo es necesario' : null,
                              isExpanded: true,
                              hint: Text('País'),
                              isDense: true,
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                                color: IdtColors.grayBtn,
                              ),
                              menuMaxHeight: sizeScreen.height * 0.6,
                              iconSize: 38,
                              style: textTheme.textButtomWhite.copyWith(
                                  color: IdtColors.grayBtn,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              items: countries.map<DropdownMenuItem<String>>(
                                  (String option) {
                                return DropdownMenuItem<String>(
                                  child: Text('$option',
                                      // style: textTheme.textDetail,
                                      style: TextStyle(color: Colors.black54)),
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
                            SizedBox(
                              height: 8,
                            ),
                            DropdownButtonFormField<String>(
                              decoration: KTextFieldDecoration().copyWith(
                                  contentPadding: EdgeInsets.only(
                                      bottom: 0, top: 0, left: 20, right: 5)),
                              validator: (value) => value == null
                                  ? '* La ciudad / providencia es necesario'
                                  : null,
                              value: dropdownValueCity,
                              isExpanded: true,
                              hint: Text('Ciudad'),
                              isDense: true,
                              menuMaxHeight: sizeScreen.height * 0.6,
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
                                  .map<DropdownMenuItem<String>>(
                                      (String option) {
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    '$option',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  value: option,
                                );
                              }).toList(),
                              onChanged: (String? newCountryValue) {
                                setState(() {
                                  dropdownValueCity = newCountryValue!;
                                });
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (value) => viewModel.validateEmail(
                                  value, _controllerEmail.text),
                              keyboardType: TextInputType.emailAddress,
                              style: textTheme.textDetail,
                              controller: _controllerEmail,
                              decoration: KTextFieldDecoration()
                                  .copyWith(labelText: 'Correo electrónico'),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (value) => viewModel.validatePasswords(
                                  _controllerPass.text,
                                  _controllerConfirmPass.text),
                              keyboardType: TextInputType.url,
                              style: textTheme.textDetail,
                              controller: _controllerPass,
                              obscureText: true,
                              decoration: KTextFieldDecoration()
                                  .copyWith(labelText: 'Contraseña'),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) async {
                                print("asdadda");
                                createCount();
                              },
                              style: textTheme.textDetail,
                              controller: _controllerConfirmPass,
                              obscureText: true,
                              decoration: KTextFieldDecoration()
                                  .copyWith(labelText: 'Confirmar contraseña'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BtnGradient('Crear cuenta',
                                colorGradient: IdtGradients.orange,
                                textStyle: textTheme.textButtomWhite.copyWith(
                                    fontSize: 16,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w700),
                                // onPressed: () => _validations(),
                                onPressed: () {
                              createCount();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                            }),
                            SizedBox(
                              height: 20,
                            ),
                            LoginButtons(
                                logout: viewModel.logOut,
                                login: viewModel.login,
                                alert: _showAlert()),
                            Text(
                              'Oficina de turismo de Bogotá',
                              style: textTheme.textDetail.copyWith(
                                fontSize: 8.5,
                                color: IdtColors.gray,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              loading
            ],
          ),
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

  void createCount() {
    if (_formKey.currentState!.validate()) {
      // viewModel.loginResponse(emailController.text, passwordController.text);
      // _validations();

      //Todo se debe bajar el keyBoard cuando se cree el usuario,
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
    } else {
      _showAlert();
    }
  }

  _onSuccessRegister() {
    final route = locator<IdtRoute>();
    context.showDialogObservation(
        titleDialog: 'Éxito',
        bodyTextDialog: 'Cuenta creada exitosamente!',
        textPrimaryButton: 'aceptar / cerrar',
        actionPrimaryButtom:


        route.goHome
    );
  }
}

//Para dispositivos pequeños
double scaleSmallDevice(BuildContext context) {
  final size = MediaQuery.of(context).size;
  // For tiny devices.
  if (size.height < 600) {
    return 100;
  }
  // For normal devices.
  return 150;
}

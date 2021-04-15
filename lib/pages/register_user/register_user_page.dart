import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:bogota_app/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import 'register_user_view_model.dart';

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
  final _controllerName = TextEditingController();
  final _controllerLastNames = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPass = TextEditingController();
  final _controllerConfirmPass = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    _controllerEmail.text = '';
    _controllerName.text = '';
    _controllerLastNames.text = '';
    _controllerEmail.text = '';
    _controllerPass.text = '';
    _controllerConfirmPass.text = '';

    final viewModel = context.read<RegisterUserViewModel>();
    super.initState();
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
    String dropdownValue = 'One';

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
          color: IdtColors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          width: 2,
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
            image: AssetImage(IdtAssets.splash),
            width: size.width,
            height: size.height * 0.47,
            fit: BoxFit.cover,
          ),
          Positioned(
            // curva
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              child: SvgPicture.asset(
                IdtAssets.curve_up,
                color: IdtColors.white,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            // Logo de bogota
            top: size.height / 6,
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
        ],
      );
    }

    Widget _btnGradient(IconData icon, List<Color> listColors) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(0),
        child: Container(
            decoration: StylesMethodsApp()
                .decorarStyle(listColors, 30, Alignment.bottomCenter, Alignment.topCenter),
            padding: EdgeInsets.symmetric(vertical: 9),
            alignment: Alignment.center,
            child: Text(
              'Crear Cuenta',
              style: textTheme.textButtomWhite,
              textAlign: TextAlign.center,
            )),
        onPressed: () {},
      );
    }

    return SingleChildScrollView(
      reverse: true,
      child: Container(
        color: IdtColors.white,
        child: Column(
          children: [
            _header(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                height: size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('BIENVENIDO',
                        style: textTheme.textMenu
                            .copyWith(fontWeight: FontWeight.w700, color: IdtColors.gray)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Lorem adipiscing elít. sed diam domummy', style: textTheme.textDetail),
                    SizedBox(
                      height: 25,
                    ),
                    TextFieldCustom(
                        style: textTheme.textDetail,
                        controller: _controllerName,
                        decoration: KTextFieldDecoration.copyWith(hintText: 'Nombre')),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldCustom(
                      style: textTheme.textDetail,
                      controller: _controllerLastNames,
                      decoration: KTextFieldDecoration.copyWith(hintText: 'Apellidos'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 38,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        // hint: 'Motivo del Viaje',
                        value: dropdownValue,
                        isDense: true,
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: IdtColors.grayBtn,
                        ),
                        iconSize: 38,
                        style: textTheme.textButtomWhite.copyWith(
                            color: IdtColors.grayBtn, fontSize: 15, fontWeight: FontWeight.w500),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['One', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldCustom(
                      style: textTheme.textDetail,
                      controller: _controllerEmail,
                      decoration: KTextFieldDecoration.copyWith(hintText: 'Correo electrónico'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldCustom(
                      style: textTheme.textDetail,
                      controller: _controllerPass,
                      decoration: KTextFieldDecoration.copyWith(hintText: 'Contraseña'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFieldCustom(
                      style: textTheme.textDetail,
                      controller: _controllerConfirmPass,
                      decoration: KTextFieldDecoration.copyWith(hintText: 'Comfirmar contraseña'),
                    ),
                    Spacer(),
                    BtnGradient(
                      'Crear cuenta',
                      colorGradient: IdtGradients.orange,
                      textStyle: textTheme.textButtomWhite.copyWith(fontSize: 17),
                    ),
                    Spacer(),
                    Text(
                      'Oficina de turismo de Bogotá',
                      style: textTheme.textDetail.copyWith(fontSize: 10, color: IdtColors.gray),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            loading,
          ],
        ),
      ),
    );
  }
}

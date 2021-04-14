import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/style_method.dart';
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
  final _controllerEmail = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    _controllerEmail.text = '';
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
    final bottom = MediaQuery.of(context).viewInsets.bottom;


    final KTextFieldInputDecoration = InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      isDense: true,
      hintStyle: textTheme.textButtomWhite.copyWith(color: IdtColors.grayBtn),
      hintText: '',
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
            height: size.height * 0.5,
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
            top: size.height / 5.5,
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
        // reverse: true,
      child: Container(
        color: IdtColors.white,
        child: Column(
          children: [
            _header(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                height: size.height*0.5,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('BIENVENIDO', style: textTheme.textMenu),
                    Text('Lorem adipiscing elít. sed diam domummy', style: textTheme.textDetail),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: textTheme.textDetail,
                      controller: _controllerEmail,
                      decoration: KTextFieldInputDecoration.copyWith(hintText: 'Nombre'),
                    ),
                    SizedBox(
                      height: 5,
                    ),TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: textTheme.textDetail,
                      controller: _controllerEmail,
                      decoration: KTextFieldInputDecoration.copyWith(hintText: 'Apellido'),
                    ),
                    SizedBox(
                      height: 5,
                    ),TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: textTheme.textDetail,
                      controller: _controllerEmail,
                      decoration: KTextFieldInputDecoration.copyWith(hintText: 'Correo electronico'),
                    ),
                    SizedBox(
                      height: 5,
                    ),TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: textTheme.textDetail,
                      controller: _controllerEmail,
                      decoration: KTextFieldInputDecoration.copyWith(hintText: 'Contraseña'),
                    ),
                    SizedBox(
                      height: 5,
                    ),TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: textTheme.textDetail,
                      controller: _controllerEmail,
                      decoration: KTextFieldInputDecoration.copyWith(hintText: 'Comfirmar contraseña'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _btnGradient(IdtIcons.mappin, IdtGradients.orange),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Oficina de turismo de Bogotá', style: textTheme.bodyText2),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            loading,
          ],
        ),
      ),
    );
  }
}

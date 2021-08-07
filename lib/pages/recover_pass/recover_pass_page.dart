import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/extensions/idt_dialog.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import 'recover_pass_view_model.dart';

class RecoverPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecoverPassViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return RecoverPassWidget();
      },
    );
  }
}

class RecoverPassWidget extends StatefulWidget {
  @override
  _RecoverPassWidgetState createState() => _RecoverPassWidgetState();
}

class _RecoverPassWidgetState extends State<RecoverPassWidget> {
  final _controllerEmail = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    _controllerEmail.text = '';
    final viewModel = context.read<RecoverPassViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecoverPassViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: IdtColors.white,
        body: _buildRecoverPass(viewModel),
      ),
    );
  }

  Widget _buildRecoverPass(RecoverPassViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final _route = locator<IdtRoute>();
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();
    final bottom = MediaQuery.of(context)
        .viewInsets
        .bottom; // Calcula el tamaño visible cuando aparece el keyboard

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
            image: AssetImage(IdtAssets.splash),
            width: size.width,
            height: size.height * 0.6,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 250,
              // bottom: 100,
              left: -12,
              right: 0,
              child: SizedBox(
                child: Image(image: AssetImage(IdtAssets.curve_up),
                    height: size.height * 0.8
                ),

/*                SvgPicture.asset(IdtAssets.curve_up,
                    color: IdtColors.white, fit: BoxFit.fill),*/
              )),
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
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: size.height / 2 * 1.05,
              width: size.width,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
            Text(
              'RESTABLECER CONTRASEÑA',
              style: textTheme.textMenu.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: IdtColors.gray,
                  letterSpacing: 0.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1,
            ),
            Text('Ingresa el correo asociado a tu cuenta, allí recibirás instrucciones para restablecer tu contraseña', style: textTheme.textDetail),
            SizedBox(
              height: 50,
            ),
          ],))
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
              'Restablecer contraseña',
              style: textTheme.textButtomWhite.copyWith(fontSize: 17),
              textAlign: TextAlign.center,
            )),
        onPressed: () {},
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Column(
            children: [
              _header(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  height: size.height * 0.5 - 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: textTheme.textDetail,
                          controller: _controllerEmail,
                          decoration: KTextFieldDecoration.copyWith(hintText: 'Correo electrónico')),
                      SizedBox(
                        height: 10,
                      ),
                      BtnGradient('Restablecer contraseña',
                            onPressed: () async {
                          await _recoverPasswordOnPressed();
                        },
                          colorGradient: IdtGradients.orange,
                          textStyle: textTheme.textButtomWhite.copyWith(
                              fontSize: 16, letterSpacing: 0.0, fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 16,
                      ),
                      Text('o recuperar a través de',
                          style: textTheme.textDetail.copyWith(fontSize: 14, color: IdtColors.gray)),
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

                      Text('Oficina de turismo de Bogotá',
                          style: textTheme.textDetail.copyWith(
                            fontSize: 8.5,
                            color: IdtColors.gray,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              loading,
            ],
          ),
        ),)
      ],
    );
  }

  Future<void> _recoverPasswordOnPressed() async {
     try {
      final response = await context
          .read<RecoverPassViewModel>()
          .recoverPassword(_controllerEmail.text);
      _showAlert('Notificación',
          'Se ha enviado un email para recuperar tu contraseña');
    } catch (e) {
      _showAlert('oh oh!\n Algo ha salido mal...', "$e");
    }
  }

  _showAlert(String tittle, String message) {
    context.showDialogObservation(
      titleDialog: tittle,
      bodyTextDialog: message,
      textPrimaryButton: 'aceptar / cerrar',
    );
  }
}

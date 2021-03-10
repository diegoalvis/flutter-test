import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile_edit/profile_edit_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class ProfileEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileEditViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
      ),
      builder: (context, _) {
        return ProfileEditWidget();
      },
    );
  }
}

class ProfileEditWidget extends StatefulWidget {
  @override
  _ProfileEditWidgetState createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<ProfileEditWidget> {

  final _controllerPassword = TextEditingController();
  final _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerEmail.text = 'juan.rivas@iddt.gov.co';
    _controllerPassword.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileEditViewModel>();

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: IdtGradients.green,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Scaffold(
          appBar: IdtAppBar(viewModel.onpenMenu),
          backgroundColor: IdtColors.transparent,
          body: _buildProfileEdit(viewModel)
        ),
      ),
    );
  }

  Widget _buildProfileEdit(ProfileEditViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;
    final menu = viewModel.status.openMenu
        ? IdtMenu(closeMenu: viewModel.closeMenu)
        : SizedBox.shrink();

    final KTextFieldInputDecoration = InputDecoration(

      contentPadding: EdgeInsets.all(10.0),
      hintStyle: textTheme.textButtomWhite,
      hintText: 'Nombre de usuario o Email',
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          width: 1.2,
          color: IdtColors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        borderSide: BorderSide(
          width: 2.5,
          color: IdtColors.white,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
    );

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: LayoutBuilder(
            builder: (context, constraint) {

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                              fit: BoxFit.fill
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Editar Perfil',
                          style: textTheme.textButtomWhite.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Juan Diego rivas Cardona',
                          style: textTheme.textButtomWhite.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Nombre',
                          style: textTheme.textButtomWhite,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          style: textTheme.textButtomWhite.copyWith(
                            fontSize: 16
                          ),
                          controller: _controllerEmail,
                          decoration: KTextFieldInputDecoration,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Nombre de Usuario',
                          style: textTheme.textButtomWhite,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Rivasjd_',
                          style: textTheme.textButtomWhite.copyWith(
                            fontSize: 18,
                          )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          textAlign: TextAlign.center,
                          style: textTheme.textMenu.copyWith(
                            color: IdtColors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          controller: _controllerPassword,
                          decoration: KTextFieldInputDecoration.copyWith(
                            hintText: 'Contraseña'
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Contraseña',
                          style: textTheme.textButtomWhite,
                        ),
                        Spacer(),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton(
                          child: Text(
                            'Cambiar mi contraseña',
                            style: textTheme.textButtomWhite,
                          ),
                          onPressed: () {
                            print("cambiar mi contraseña");
                          },
                        ),
                        Spacer(
                          flex: 4,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextButton(
                          child: Text(
                            'Desactivar mi cuenta',
                            style: textTheme.textButtomWhite.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                            )
                          ),
                          onPressed: () {
                            print("cambiar mi contraseña");
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          right: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.close,
                size: 40,
                color: IdtColors.white,
              ),
              Icon(
                Icons.check,
                size: 40,
                color: IdtColors.white,
              ),
            ],
          ),
        ),
        menu
      ],
    );
  }
}


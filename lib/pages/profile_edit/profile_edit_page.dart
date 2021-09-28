import 'package:bogota_app/data/model/request/user_data_request.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/login/login_page.dart';
import 'package:bogota_app/pages/profile/profile_view_model.dart';
import 'package:bogota_app/pages/profile_edit/profile_edit_view_model.dart';
import 'package:bogota_app/pages/profile_edit/profile_effect.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import 'package:another_flushbar/flushbar.dart';

class ProfileEditPage extends StatelessWidget {
  final UserModel user;

  // final String emailUser;
  // final String nameUser;
  // final String lastName;

  ProfileEditPage(this.user);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ProfileEditViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return ProfileEditWidget(user);
      },
    );
  }
}

class ProfileEditWidget extends StatefulWidget {
  final UserModel _user;

  ProfileEditWidget(this._user);

  @override
  _ProfileEditWidgetState createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<ProfileEditWidget> {
  final _nameControllerUser = TextEditingController();
  final _lastNameControllerUser = TextEditingController();
  final _emailController = TextEditingController();
  bool changeText = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void cancelChangeDataUser() {
    String nameOriginal = widget._user.name!;
    String lastNameOriginal = widget._user.lastName!;
    String emailOriginal = widget._user.email!;
    setState(() {
      _emailController.text = emailOriginal;
      _nameControllerUser.text = nameOriginal;
      _lastNameControllerUser.text = lastNameOriginal;
      changeText = false;
    });
  }

  void saveChangeDataUser() {
    setState(() {
      changeText = false;
    });
  }

  void _changeValueController() {
    setState(() {
      changeText = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameControllerUser.text = widget._user.name!;
    _lastNameControllerUser.text = widget._user.lastName!;
    _emailController.text = widget._user.email!;
    _emailController.addListener(_changeValueController);
    _lastNameControllerUser.addListener(_changeValueController);
    _nameControllerUser.addListener(_changeValueController);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameControllerUser.dispose();
    _lastNameControllerUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileEditViewModel>();

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: IdtGradients.green,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: WillPopScope(
            onWillPop: viewModel.offMenuBack,
            child: Scaffold(
                appBar: IdtAppBar(viewModel.openMenu),
                backgroundColor: IdtColors.transparent,
                body: _buildProfileEdit(viewModel)),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileEdit(ProfileEditViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: viewModel.status.openMenu
          ? IdtMenu(
              closeMenu: viewModel.closeMenu,
            )
          : SizedBox.shrink(),
    );

    InputDecoration KeditTextFieldDecoration() {
      return InputDecoration(
        contentPadding: EdgeInsets.all(12.0),
        isDense: true,
        hintStyle: textTheme.optionsGray,
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
            width: 2.0,
            color: IdtColors.white,
          ),
        ),
      );
    }

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
                          flex: 3,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            FutureBuilder(
                              future: viewModel.getNameUser(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  // while data is loading:
                                  print(snapshot);
                                  return Center(
                                    child: CircleAvatar(
                                      foregroundColor: IdtColors.white,
                                      backgroundColor: IdtColors.blue,
                                      radius: 70.0,
                                    ),
                                  );
                                } else {
                                  print(snapshot);
                                  return CircleAvatar(
                                    foregroundColor: IdtColors.white,
                                    backgroundColor: IdtColors.blue,
                                    radius: 70.0,
                                    child: Text(
                                      snapshot.data.toString()[0].toUpperCase(),
                                      style: TextStyle(fontSize: 50),
                                    ),
                                  );
                                }
                              },
                            ),
                            // Positioned(
                            //   bottom: 3,
                            //   child: Container(
                            //     child: IconButton(
                            //       icon: Icon(
                            //         Icons.camera_alt,
                            //         color: IdtColors.white,
                            //       ),
                            //       iconSize: 37,
                            //       onPressed: () {},
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Editar Perfil',
                          style: textTheme.textButtomWhite.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Spacer(
                          flex: 5,
                        ),
                        Text(
                          widget._user.name!,
                          textAlign: TextAlign.center,
                          style: textTheme.textButtomWhite.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Nombre',
                          style: textTheme.textButtomWhite,
                        ),
                        // TextField(
                        //   keyboardType: TextInputType.emailAddress,
                        //   textAlign: TextAlign.center,
                        //   style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                        //   decoration: KTextFieldInputDecoration,
                        //   controller: _controllerFullNameUser,
                        // ),
                        SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          // initialValue: 'valor inicial',
                          // validator: (value) => viewModel.validateEmail(value, emailController.text),
                          style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                          controller: _nameControllerUser,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          decoration: KeditTextFieldDecoration(),
                        ),

                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Nombre de Usuario',
                          style: textTheme.textButtomWhite,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          // validator: (value) => viewModel.validateEmail(value, emailController.text),
                          style:
                              textTheme.textButtomWhite.copyWith(fontSize: 16),
                          controller: _lastNameControllerUser,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          decoration: KeditTextFieldDecoration(),
                        ),

                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Apellido de Usuario',
                          style: textTheme.textButtomWhite,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            textAlign: TextAlign.center,
                            style: textTheme.textButtomWhite
                                .copyWith(fontSize: 16),
                            controller: _emailController,
                            decoration: KeditTextFieldDecoration()),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Email',
                          style: textTheme.textButtomWhite,
                        ),
                        SizedBox(
                          height: 15,
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
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            onPressed: () => _deactivateAccount(viewModel)),
                        SizedBox(
                          height: 12,
                        ),
                        TextButton(
                            child: Text(
                              'Cerrar Sesión',
                              style: textTheme.textButtomWhite.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            onPressed: () => viewModel.goLoginAll()),
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
        changeText
            ? Positioned(
                top: 40,
                left: 30,
                right: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 40,
                          color: IdtColors.white,
                        ),
                        onPressed: () {
                          cancelChangeDataUser();
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.check,
                          size: 40,
                          color: IdtColors.white,
                        ),
                        onPressed: () {
                          saveChangeDataUser();
                          viewModel.updateUserData(
                              newLastName: _lastNameControllerUser.text,
                              newName: _nameControllerUser.text,
                              newEmail: _emailController.text,
                              idUser: widget._user.id);
                        }),
                  ],
                ),
              )
            : SizedBox.shrink(),
        menu
      ],
    );
  }

  showSnack(String title, {Function? onPressed, int? duration}) async {
    await Flushbar(
      blockBackgroundInteraction: true,
      isDismissible: false,
      title: 'Atención!',
      message: title,
      duration: Duration(seconds: 5),
      onTap: (_) {
        if (onPressed != null) {
          onPressed();
        }
      },
    ).show(context);
  }

  _deactivateAccount(ProfileEditViewModel viewModel) async {
    try {
      bool response = await viewModel.deleteUser();
      if (response == true) {
        await showSnack("Cuenta eliminada exitosamente",
            onPressed: viewModel.goLoginAll);
        viewModel.goLoginAll();
      } else {
        await showSnack("Hubo un error, intenta nuevamente");
      }
    } catch (e) {
      await showSnack("Hubo un error, intenta nuevamente");
    }
  }
}

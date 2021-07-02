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
  final String emailUser;
  late String fullNameUser = '$nameUser $lastName';
  final String nameUser;
  final String lastName;

  ProfileEditPage(this.emailUser, this.nameUser, this.lastName);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileEditViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return ProfileEditWidget(emailUser, fullNameUser);
      },
    );
  }
}

class ProfileEditWidget extends StatefulWidget {
  final String _emailUser;
  final String _fullNameUser;

  ProfileEditWidget(this._emailUser, this._fullNameUser);

  @override
  _ProfileEditWidgetState createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<ProfileEditWidget> {
  final _controllerFullNameUser = TextEditingController();
  final _controllerEmail = TextEditingController();
  bool changeText = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
  void cancelChangeDataUser() {
    String fullNameOriginal = widget._fullNameUser;
    String emailOriginal = widget._emailUser;
    setState(() {
      _controllerEmail.text = emailOriginal;
      _controllerFullNameUser.text = fullNameOriginal;
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
    _controllerEmail.text = widget._emailUser;
    _controllerEmail.addListener(_changeValueController);

    _controllerFullNameUser.text = widget._fullNameUser;
    _controllerFullNameUser.addListener(_changeValueController);
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerFullNameUser.dispose();
    super.dispose();
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
        child: ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
              appBar: IdtAppBar(viewModel.openMenu),
              backgroundColor: IdtColors.transparent,
              body: _buildProfileEdit(viewModel)),
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

    final KTextFieldInputDecoration = InputDecoration(
      contentPadding: EdgeInsets.all(12.0),
      isDense: true,
      hintStyle: textTheme.textButtomWhite,
      hintText: 'Nombre de usuario',
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
                          flex: 3,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            FutureBuilder(
                              future: viewModel.getNameUser(),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                          style: textTheme.textButtomWhite
                              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Spacer(
                          flex: 5,
                        ),
                        Text(
                          widget._fullNameUser,
                          style: textTheme.textButtomWhite
                              .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
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
                          style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                          decoration: KTextFieldInputDecoration,
                          controller: _controllerFullNameUser,
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
                        TextField(
                          textAlign: TextAlign.center,
                          style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                          controller: _controllerEmail,
                          decoration: KTextFieldInputDecoration.copyWith(
                            hintText: 'Email',
                          ),
                        ),
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
                              style: textTheme.textButtomWhite
                                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            onPressed: ()=>_deactivateAccount(viewModel) ),
                        SizedBox(
                          height: 12,
                        ),
                        TextButton(
                            child: Text(
                              'Cerrar Sesión',
                              style: textTheme.textButtomWhite
                                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
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
      onTap: (_){
        if(onPressed!= null){
          onPressed();
        }
      },
    ).show(context);
  }

  _deactivateAccount(ProfileEditViewModel viewModel) async {
    try {
      bool response = await viewModel.deleteUser();
      if (response == true) {
        await showSnack("Cuenta eliminada exitosamente", onPressed: viewModel.goLoginAll);
        viewModel.goLoginAll();
      } else {
        await showSnack("Hubo un error, intenta nuevamente");
      }
    } catch (e) {
      await showSnack("Hubo un error, intenta nuevamente");
    }
  }
}

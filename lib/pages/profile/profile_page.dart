import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor

>()
      ),
      builder: (context, _) {
        return ProfileWidget();
      },
    );
  }
}

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: IdtGradients.green,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Scaffold(
          appBar: IdtAppBar(viewModel.onpenMenu),
          backgroundColor: IdtColors.transparent,
          body: _buildProfile(viewModel)
        ),
      ),
    );
  }

  Widget _buildProfile(ProfileViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;

    final menu = viewModel.status.openMenu
        ? IdtMenu(closeMenu: viewModel.closeMenu)
        : SizedBox.shrink();

    Widget _elevationButtonCustom(String dataText){

      return ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SizedBox(
                width: 30,
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                dataText,
                style: textTheme.titleGray.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                width: 30,
              ),
            ),
          ],
        ),
        onPressed: viewModel.goSettingPage,
        style: ElevatedButton.styleFrom(
          primary: IdtColors.white,
          onPrimary: IdtColors.gray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
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
                    image: NetworkImage(
                      'https://googleflutter.com/sample_image.jpg'
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Juan Diego Rivas Cardoba',
                style: textTheme.textButtomWhite.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Colombia',
                style: textTheme.textButtomWhite,
              ),
              Spacer(),
              TextButton(
                child: Text(
                  'Editar mi perfil',
                  style: textTheme.textButtomWhite.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                  ),
                ),
                onPressed: viewModel.goProfileEditPage,
              ),
              Spacer(),
              _elevationButtonCustom('Configuración de la cuenta'),
              Spacer( flex: 4),
              Text(
                'Política de Tratamiento de Datos',
                style: textTheme.textButtomWhite.copyWith(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        menu
      ],
    );
  }
}


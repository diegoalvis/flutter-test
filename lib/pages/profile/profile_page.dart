import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
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
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().onInit();
    });
    final viewModel = context.read<ProfileViewModel>();
    viewModel.getDataUser('290');
    super.initState();
  }

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
            appBar: IdtAppBar(viewModel.openMenu),
            backgroundColor: IdtColors.transparent,
            body: _buildProfile(viewModel)),
      ),
    );
  }

  Widget _buildProfile(ProfileViewModel viewModel) {
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;

    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: viewModel.status.openMenu
          ? IdtMenu(
              closeMenu: viewModel.closeMenu,
            )
          : SizedBox.shrink(),
    );

    Widget _elevationButtonCustom(String dataText) {
      return ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: SizedBox(
              width: 30,
            )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                dataText,
                style: textTheme.titleGray.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
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
                    image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              viewModel.status.dataUser == null
                  ? CircularProgressIndicator()
                  : Text(
                      '${viewModel.status.dataUser!.name ?? '**Nombre'} ${viewModel.status.dataUser!.lastName!}',
                      style: textTheme.textButtomWhite
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
              SizedBox(
                height: 8,
              ),
              viewModel.status.dataUser == null
                  ? SizedBox.shrink()
                  : Text(
                      viewModel.status.dataUser!.country!,
                      style: textTheme.textButtomWhite.copyWith(
                        fontSize: 12,
                      ),
                    ),
              Spacer(),
              TextButton(
                child: Text(
                  'Editar mi perfil',
                  style:
                      textTheme.textButtomWhite.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                onPressed: viewModel.goProfileEditPage,
              ),
              Spacer(),
              _elevationButtonCustom('Configuración de la cuenta'),
              Spacer(flex: 4),
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
        loading,
        menu
      ],
    );
  }
}

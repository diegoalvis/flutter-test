import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/setting/setting_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor

>()
      ),
      builder: (context, _) {
        return SettingWidget();
      },
    );
  }
}

class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<SettingViewModel>();

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: IdtColors.white,
        ),
        child: Scaffold(
          appBar: IdtAppBar(viewModel.onpenMenu),
          backgroundColor: Colors.transparent,
          // floatingActionButton: IdtFab(homeSelect: true),
          body: _buildConfigApp(viewModel)
        ),
      ),
    );
  }

  Widget _buildConfigApp(SettingViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;
    bool isSwitched = true;

    final menu = viewModel.status.openMenu
        ? IdtMenu(closeMenu: viewModel.closeMenu)
        : SizedBox.shrink();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all( 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Align(
                  child: Text(
                    'Configuración',
                    style: textTheme.titleBlack.copyWith(
                      fontWeight: FontWeight.w700,
                      color: IdtColors.black.withOpacity(0.8),
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                alignment: Alignment.centerLeft,
                height: 45,
                child: Text(
                  'Tu actividad',
                  style: textTheme.optionsGray,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                height: 45,
                child: Text(
                  'Idioma',
                  style: textTheme.optionsGray,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Activar notificaciones',
                      style: textTheme.optionsGray,
                    ),
                    FlutterSwitch(
                      value: viewModel.status.switchNotification,
                      switchBorder: Border.all(color: IdtColors.grayBtn),
                      activeColor: IdtColors.white,
                      activeToggleColor: IdtColors.green,
                      inactiveColor: IdtColors.white,
                      inactiveToggleColor: IdtColors.grayBtn.withOpacity(0.9),
                      onToggle: viewModel.changeNotification,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Activar ubicación',
                      style: textTheme.optionsGray,
                    ),
                    FlutterSwitch(
                      value: viewModel.status.switchNotification2,
                      switchBorder: Border.all(color: IdtColors.grayBtn),
                      activeColor: IdtColors.white,
                      activeToggleColor: IdtColors.green,
                      inactiveColor: IdtColors.white,
                      inactiveToggleColor: IdtColors.grayBtn.withOpacity(0.9),
                      onToggle: viewModel.changeNotification2,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerLeft,
                height: 45,
                child: Text(
                  'Lugares guardados',
                  style: textTheme.optionsGray,
                ),
              ),
            ],
          ),
        ),
        menu
      ],
    );
  }
}
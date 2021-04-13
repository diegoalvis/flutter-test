import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final scrollController = ScrollController();

  @override
  void initState() {
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
        body: _buildRecoverPass(viewModel),
      ),
    );
  }

  Widget _buildRecoverPass(RecoverPassViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final _route = locator<IdtRoute>();
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    Widget _header() {
      return Stack(
        children: [
          Column(
            children: [
              Image(
                //imagen de fondo
                image: AssetImage(IdtAssets.splash),
                width: size.width,
                height: size.height * 0.6,
                fit: BoxFit.cover,
              ),
            ],
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
                Container(
                  height: 140,
                    child: Image.asset(
                  IdtAssets.logo_bogota,
                  fit: BoxFit.scaleDown,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Text('App Oficial de Bogotá',
                      style: textTheme.textWhiteShadow.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            _header(),
          ],
        ),
        loading,
      ],
    );
  }
}

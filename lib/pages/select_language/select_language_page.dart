import 'dart:ffi';
import 'dart:ui';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/select_language/select_language_view_model.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:bogota_app/widget/carouselLanguages.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flag/flag.dart';
import '../../app_theme.dart';

class SelectLanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectLanguageViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return SelectLanguageWidget();
      },
    );
  }
}

class SelectLanguageWidget extends StatefulWidget {
  @override
  _SelectLanguageWidgetState createState() => new _SelectLanguageWidgetState();
}

class _SelectLanguageWidgetState extends State<SelectLanguageWidget> {
  final _route = locator<IdtRoute>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<SelectLanguageViewModel>().onInit();
    });
    // final viewModel = context.read<SelectLanguageViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SelectLanguageViewModel>();
    final loading =
    viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(IdtAssets.splash),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              height: sizeScreen.height * 0.7,
              child: Column(
                children: [
                  Image.asset(
                    IdtAssets.logo_bogota,
                    height: 80,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  viewModel.status.isLoading == false
                      ? CarouselLanguages(
                          viewModel.nextHome,
                          languages: viewModel.status.languagesAvalibles,
                          sizeScreen: sizeScreen,
                          selectColor: Colors.white,
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Escoge tu idioma',
                    style: Theme.of(context).textTheme.textButtomWhite,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'choose your language',
                    style: Theme.of(context).textTheme.textButtomWhite,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Choisissez votre langue',
                    style: Theme.of(context).textTheme.textButtomWhite,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'escolha seu idioma',
                    style: Theme.of(context).textTheme.textButtomWhite,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: sizeScreen.width * 0.5,
                    child: viewModel.status.isButtonEnable
                        ? BtnGradient(
                            "CONTINUAR",
                            onPressed: () => viewModel.goHomeWithWordsAndImagesMenu(),
                            colorGradient: IdtGradients.orange,
                            textStyle: Theme.of(context).textTheme.textButtomWhite.copyWith(
                                fontSize: 16, letterSpacing: 0.0, fontWeight: FontWeight.w700),
                          )
                        : SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),
        ),
        loading,
      ],
    ));
  }
}

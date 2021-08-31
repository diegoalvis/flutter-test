import 'dart:ui';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/testData.dart';
import 'package:bogota_app/pages/profile/profile_view_model.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:bogota_app/widget/carouselLanguages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flag/flag.dart';
import '../../app_theme.dart';

class SelectLanguagePage extends StatelessWidget {
  SelectLanguagePage();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
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
  @override
  void initState() {
    super.initState();
    // final viewModel = context.read<SplashViewModel>();
    // viewModel.getSplash();
  }

  @override
  Widget build(BuildContext context) {
    final _route = locator<IdtRoute>();
    Size sizeScreen = MediaQuery.of(context).size;
    final List dummyList = List.generate(4, (index) {
      return {"subtitle": "This is the subtitle $index"};
    });

    int? typeLanguage = -1;
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
                  Stack(
                    children: [
                      CarouselLanguages(sizeScreen: sizeScreen, typeLanguage: 0, selectColor: Colors.white,),
                      Container(
                        alignment: Alignment.center,
                        width: 20.0,
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            colors: <Color>[Colors.black12, Colors.transparent],
                            // red to yellow
                          ),
                        ),
                      )
                    ],
                  ),
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
                    child: BtnGradient(
                      "CONTINUAR",
                      onPressed: () => _route.goHomeRemoveAll(),
                      colorGradient: IdtGradients.orange,
                      textStyle: Theme.of(context)
                          .textTheme
                          .textButtomWhite
                          .copyWith(fontSize: 16, letterSpacing: 0.0, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

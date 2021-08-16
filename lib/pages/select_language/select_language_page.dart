import 'dart:ui';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/data/local/user.dart';
import 'package:bogota_app/data/model/user_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/profile/profile_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/btn_gradient.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/games/v1.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

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
    Size sizeScreen = MediaQuery.of(context).size;
    // final viewModel = context.watch<SplashViewModel>();

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
              // color: IdtColors.red,
              height: sizeScreen.height * 0.7,
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(IdtAssets.logo_bogota),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: sizeScreen.width * 0.7,
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 60.0, viewportFraction: 0.3, enableInfiniteScroll: false),
                      items: [
                        1,
                        2,
                        3,
                        4,
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                color: IdtColors.red,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(IdtAssets.circle_flag),
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  )
,
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

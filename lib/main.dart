import 'dart:async';

import 'package:bogota_app/pages/%20recover_pass/recover_pass_page.dart';
import 'package:bogota_app/pages/detail/detail_page.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/splash/splash_page.dart';
import 'package:bogota_app/widget/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bogota_app/app_theme.dart';
import 'configure/get_it_locator.dart';
import 'configure/idt_route.dart';


void main() async {

  setUpLocator();
  await locator.allReady();

  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    // TODO: Captura de errores con Crashlytics
  });
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: IdtRoute().navigatorKey,
      debugShowCheckedModeBanner: false,

      title: 'Bogotá App',
      theme: AppTheme.build(),
      home: SplashPage(),
      // home: RecoverPassPage(),
      // home: DetailPage(),
      //onGenerateRoute: locator<IdtRoute>().generateRoute
    );
  }
}
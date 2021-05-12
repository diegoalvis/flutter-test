import 'dart:async';
import 'dart:io';

import 'package:bogota_app/pages/%20recover_pass/recover_pass_page.dart';
import 'package:bogota_app/pages/detail/detail_page.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/login/login_page.dart';
import 'package:bogota_app/pages/register_user/register_user_page.dart';
import 'package:bogota_app/pages/splash/splash_page.dart';
import 'package:bogota_app/widget/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bogota_app/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'configure/get_it_locator.dart';
import 'configure/idt_route.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:bogota_app/data/local/user.dart';

void main() async {

  setUpLocator();
  await locator.allReady();

  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    // TODO: Captura de errores con Crashlytics
  });

  var path = Directory.current.path;
  //Hive.init(path);
  var applicationsDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(applicationsDocumentDirectory.path);
  Hive.registerAdapter(PersonAdapter());

  var box = await Hive.openBox<Person>('userdbB');
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return MaterialApp(
      navigatorKey: IdtRoute().navigatorKey,
      debugShowCheckedModeBanner: false,

      title: 'Bogotá App',
      theme: AppTheme.build(),
      home: SplashPage(),
      // home: RegisterUserPage(),
      // home: LoginPage(),
      // home: RecoverPassPage(),
      // home: DetailPage(),
      //onGenerateRoute: locator<IdtRoute>().generateRoute
    );
  }
}
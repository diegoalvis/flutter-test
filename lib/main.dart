import 'dart:async';
import 'dart:io';

import 'package:bogota_app/pages/select_language/select_language_page.dart';
import 'package:flutter/services.dart';
import 'package:bogota_app/pages/splash/splash_page.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bogota_app/app_theme.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'configure/get_it_locator.dart';
import 'configure/idt_route.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:bogota_app/data/local/user.dart';

void main() async {
  setUpLocator();
  await locator.allReady();

  WidgetsFlutterBinding.ensureInitialized();//deshabilitar el modo horizontal(Landscape)
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    // TODO: Captura de errores con Crashlytics
    print("""
          =====================INICIA ERROR============================
    """);

    print(error);
print("""
          =====================STACKTRACE============================
    """);
    print(stackTrace);
    print("""
          =====================FINALIZA ERROR============================
    """);
  });

  var path = Directory.current.path;
  //Hive.init(path);
  var applicationsDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(applicationsDocumentDirectory.path);
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(CurrentUserAdapter());
  Hive.registerAdapter(RememberMeAdapter());

  BoxDataSesion();
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
      // home: SplashPage(),
      home: SelectLanguagePage(),
      // home: RegisterUserPage(),
      // home: LoginPage(),
      // home: RecoverPassPage(),
      // home: DetailPage(),
      //onGenerateRoute: locator<IdtRoute>().generateRoute
    );
  }
}

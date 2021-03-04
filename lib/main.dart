import 'dart:async';

import 'package:bogota_app/widget/audio_player.dart';
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
      title: 'GFiles App',
      theme: AppTheme.build(),
      home: /*ExampleApp()*/ SplashScreen(),
        //onGenerateRoute: locator<IdtRoute>().generateRoute
    );

    /*return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> Tittle())
    ],
      child: MaterialApp(
        title: "Bogota App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'MuseoSans',
          //   primaryColor: Colors.white,
          // primaryColorLight: Colors.white
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/HomePage': (BuildContext context) =>  Home(),
          '/MasAlla': (BuildContext context) =>  Mas_Alla(),
          '/Imperdibles': (BuildContext context) => Imperdibles(),
          '/Audioguias': (BuildContext context) => Audioguias(),
          '/Home_User': (BuildContext context) => Home_User(state: true,),
          //   '/': (context) => HomePage(),

        },
      ),);*/
  }


}